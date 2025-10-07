# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import numpy as np
import pyxsdb
import sys
import time
from typing import Callable, Dict, List, TypeVar
from .device_property import TsnEfccAddressTable, default_tsn_efcc_address_table

TStat = TypeVar('TimestampStatistic', bound='TimestampStatistic')

class TimestampStatistic():
    """TimestampStatistic manages timestamp information and provides basic computation of timestamps.

    TimestampStatistic holds ID and timestamp information of timestamps.
    This class support basic computation of timestamps, such as subtracting 2 timestamps to get latency, and computing bandwidth.
    """

    def __init__(self, ids=None, vals=None):
        if ids is not None:
            self._ids = np.array(ids, dtype=np.uint32)
        else:
            self._ids = np.empty((0,), dtype=np.uint32)

        if vals is not None:
            self._vals = np.array(vals, dtype=np.uint32)
        else:
            self._vals = np.empty((0,), dtype=np.uint32)

    def read_binary_file(self, filename: str) -> None:
        """Initialize TimestampStatistic by binary dump of timestamps.

        Args:
            filename (str): file of binary file.
                The binary file contains 64-bit information per timestamp.
                - ID: 32bit id
                - timestamp: 32bit timestamp (cycles)

        Returns:
            None: none
        """
        # binary file format:
        # id0, ts0, id1, ts1, ...
        x = np.fromfile(filename, dtype=np.uint32).reshape(-1, 2)
        self._ids = x[:, 0].copy()
        self._vals = x[:, 1].copy()

    def push(self, tid: int, tval: int) -> None:
        """Add timestamp information to TimestampStatistic.

        Args:
            tid (int): timestamp ID.
            tval (int): timestamp value (cycles)

        Returns:
            None: none
        """
        matched = self._ids == tid
        found = np.any(matched)
        if found:
            print(f'Warning: the same timestamp id is recorded. tid=0x{tid:08x}, ' +
                  'prev_tval=0x{self._vals[matched]}, ' +
                  'new_tval=0x{tval:08x}. ' +
                  'new_tval is not saved.')
            return

        self._ids = np.append(self._ids, [tid])
        self._vals = np.append(self._vals, [tval])

    def push_list(self, tids: List[int], tvals: List[int]) -> None:
        """Add list of timestamp information to TimestampStatistic.

        Args:
            tids (int): timestamp IDs.
            tvals (int): timestamp values (cycles)

        Returns:
            None: none
        """
        tids = np.array(tids)
        tvals = np.array(tvals)
        intersect, indices, indices_src = np.intersect1d(tids, self._ids, return_indices=True)

        for idx, idx_src in zip(indices, indices_src):
            print(f'Warning: the same timestamp id is recorded. tid=0x{tids[idx]:08x}, ' +
                  f'prev_tval=0x{self._vals[idx_src]}, ' +
                  f'new_tval=0x{tvals[idx]}. ' +
                  'new_tval is not saved.')

        # delete intersection
        if indices.size != 0:
            tids = np.delete(tids, indices)
            tvals = np.delete(tvals, indices)

        self._ids = np.append(self._ids, tids)
        self._vals = np.append(self._vals, tvals)


    def subtract(self, target: TStat) -> TStat:
        """Subtract target TimestampStatistic.

        The subtraction is done in 3 steps.

        1. Find pair of timestamps which has the same timestamp ID value.
        2. Subtract these timestamps.
        3. Create new TimestampStatistic with subtracted timestamps.

        The timestamps contained only in either self or target, the timestamps will be deleted from the new TimestampStatistic.

        Args:
            target (TimestampStatistic): target statistics to be subtracted.

        Returns:
            TimestampStatistic: new timestamp statistic.
        """
        k0 = self._ids
        k1 = target._ids
        v0 = self._vals
        v1 = target._vals

        # get intersection set of k0 and k1
        prod, k0_ind, k1_ind = np.intersect1d(k0, k1, return_indices=True)

        new_stat = TimestampStatistic()
        new_stat._ids = prod
        new_stat._vals = v0[k0_ind] - v1[k1_ind]

        return new_stat

    def add_constant(self, const_val: int) -> TStat:
        """Add offset to timestamp values, and returns new TimestampStatistic.

        Args:
            const_val (int): The constant value. new_timestamp = old_timestamp + const_val
        """
        new_stat = TimestampStatistic()
        new_stat._ids = self._ids.copy()
        new_stat._vals = self._vals + const_val
        return new_stat


    def filter(self, filter_func: Callable[[int], bool]) -> TStat:
        """Filter timestamps by filter function that maps timestamp ID to bool.

        The filter function maps timestamp ID to bool value.
        If filter_func(timestamp.id) is False, the timestamp will be deleted from the new timestamp statistic.

        Args:
            filter_func (Callable[[int], bool]): filter function

        Returns:
            TimestampStatistic: new timestamp statistic.
        """
        new_stat = TimestampStatistic()
        kv = np.array([(k, v) for k, v in zip(self._ids, self._vals) if filter_func(k)], dtype=np.uint32)
        new_stat._ids = kv[:, 0].copy()
        new_stat._vals = kv[:, 1].copy()

        return new_stat

    def filter_by_timestamp(self, filter_func: Callable[[int], bool]) -> TStat:
        """Filter timestamps by filter function that maps timestamp value to bool.

        The filter function maps timestamp value (cycles) to bool value.
        If filter_func(timestamp.value) is False, the timestamp will be deleted from the new timestamp statistic.

        Args:
            filter_func (Callable[[int], bool]): filter function

        Returns:
            TimestampStatistic: new timestamp statistic.
        """
        new_stat = TimestampStatistic()
        kv = np.array([(k, v) for k, v in zip(self._ids, self._vals) if filter_func(v)], dtype=np.uint32)
        new_stat._ids = kv[:, 0].copy()
        new_stat._vals = kv[:, 1].copy()

        return new_stat

    def get_intersection(self, reference: TStat) -> TStat:
        """Returns a new timestamp statistic which has timestamps which ID is included in reference.

        Args:
            reference (TimestampStatistic): reference timestamp statistic

        Returns:
            TimestampStatistic: new timestamp statistic.
        """
        # get intersection set of k0 and k1
        new_ids, ind, _ = np.intersect1d(self._ids, reference._ids, return_indices=True)
        new_stat = TimestampStatistic()
        new_stat._ids = new_ids.copy()
        new_stat._vals = self._vals[ind].copy()

        return new_stat

    def subgroup(self, tid_begin: int, tid_end: int) -> TStat:
        """Extract timestamps which ID meets the condition tid_begin <= ID < tid_end.

        Args:
            tid_begin (int): tid_begin
            tid_end (int): tid_end

        Returns:
            TimestampStatistic: new timestamp statistic.
        """
        def filter_func(tid):
            return tid_begin <= tid < tid_end

        return self.filter(filter_func)

    def subgroup_by_timestamp(self, ts_begin: int, ts_end: int) -> TStat:
        """Extract timestamps which value meets the condition ts_begin <= ID < ts_end.

        Args:
            ts_begin (int): ts_begin
            ts_end (int): ts_end

        Returns:
            TimestampStatistic: new timestamp statistic.
        """
        def filter_func(ts):
            return ts_begin <= ts < ts_end

        return self.filter_by_timestamp(filter_func)

    def get_stats(self) -> Dict[int, int]:
        """Returns a dictionary of statistic.

        Returns:
            Dict[int, int]: A dictionary of timestamps. key = timestamp ID, value = timestamp value (cycles)
        """
        return {k: v for k, v in zip(self._ids, self._vals)}

    def get_timestamp_ids(self) -> np.array:
        """Returns a list of timestamp IDs.

        Returns:
            np.array: A list of timestamp IDs included in this TimestampStatistic.
        """
        return self._ids

    def get_timestamps(self) -> np.array:
        """Returns a list of timestamp values (cycles).

        Returns:
            np.array: A list of timestamp values included in this TimestampStatistic.
        """
        return self._vals

    def calc_bandwidth(self, func_id_to_size: Callable[[int], int], duration_sec: float) -> float:
        """Calculate bandwidth from this statistic.

        The bandwidth is computed by the following formula.
        bandwidth [bytes/sec] = sum([size(timestamp.id) for timestamp in all_timestamps]) [bytes] / duration [seconds]

        Args:
            func_id_to_size (Callable[[int], int]): A function to map timestamp ID -> frame size.
            duration_sec (float): Elapsed time to record timestamps.

        Returns:
            float: bandwidth [bytes/sec]
        """

        total_size = 0
        for k in self._ids:
            total_size += func_id_to_size(k)

        return total_size / duration_sec

    @classmethod
    def summary_bandwidth(cls, send_stat, recv_stat, freq_mhz, func_id_to_size: Callable[[int], int], duration_sec=None, name='', f=sys.stdout) -> None:
        """Summarize bandwidth between send port and receive port. The summary is output to file object.

        Args:
            send_stat (TimestampStatistic): statistic of sender side.
            recv_stat (TimestampStatistic): statistic of receiver side.
            freq_mhz (float): The FPGA device frequency
            func_id_to_size (Callable[[int], int]): A function to map timestamp ID -> frame size.
            duration_sec (None or float): Elapsed time to record timestamps.
                If set to None, the duration is computed as the difference of
                the 1st sender timestamp and the last receiver timestamp. (Default: None)
            name (str): The name of this result. This name is shown in summary log. (Default: '')
            f (file): The output file object (text). (Default: stdout)

        Returns:
            None
        """

        if len(send_stat.get_stats()) == 0 or len(recv_stat.get_stats()) == 0:
            print('--------------------------------', file=f)
            print(f'TimestampStat({name}): id range = [:]', file=f)
            print(f'# of sent frames: 0', file=f)
            print(f'send rate: 0 Mbps', file=f)
            print(f'# of recvd frames: 0', file=f)
            print(f'recv rate: 0 Mbps', file=f)
            print(f'# of dropped frames: 0', file=f)
            print(f'drop rate: 0 %', file=f)
            return

        # Exclude timestamps that are irrelevant to send_stat
        recv_stat = recv_stat.get_intersection(send_stat)

        min_tid = np.amin(send_stat.get_timestamp_ids())
        max_tid = np.amax(recv_stat.get_timestamp_ids())

        if duration_sec is None:
            start_time = np.amin(send_stat.get_timestamps())
            end_time = np.amax(recv_stat.get_timestamps())
            duration_sec = (end_time - start_time) / freq_mhz / 1000 / 1000

        sent_frames = len(send_stat.get_timestamp_ids())
        recvd_frames = len(recv_stat.get_timestamp_ids())
        dropped_frames = sent_frames - recvd_frames
        drop_rate = dropped_frames / sent_frames

        # Mbps
        send_rate = send_stat.calc_bandwidth(func_id_to_size, duration_sec) * 8 / 1000.0 / 1000.0
        recv_rate = recv_stat.calc_bandwidth(func_id_to_size, duration_sec) * 8 / 1000.0 / 1000.0

        print('--------------------------------', file=f)
        print(f'TimestampStat({name}): id range = [0x{min_tid:08x}:0x{max_tid:08x}]', file=f)
        print(f'# of sent frames: {sent_frames}', file=f)
        print(f'send rate: {send_rate:.3f} Mbps', file=f)
        print(f'# of recvd frames: {recvd_frames}', file=f)
        print(f'recv rate: {recv_rate:.3f} Mbps', file=f)
        print(f'# of dropped frames: {sent_frames - recvd_frames}', file=f)
        print(f'drop rate: {drop_rate * 100:.3f} %', file=f)

    def summary(self, freq_mhz, name='', f=sys.stdout):
        """Computes timestamp statistic information (min, max, avg, stddev) and output to stdout or file in text format.

        Args:
            freq_mhz (float): The FPGA device frequency
            name (str): The name of this result. This name is shown in summary log. (Default: '')
            f (file): The output file object (text). (Default: stdout)

        Returns:
            None
        """

        if len(self._ids) == 0:
            print('--------------------------------', file=f)
            print(f'TimestampStat({name}): id range = [:]', file=f)
            print(f'Minimum Timestamp: 0 ns', file=f)
            print(f'Maximum Timestamp: 0 ns', file=f)
            print(f'Average Timestamp: 0 ns', file=f)
            print(f'Stddev Timestamp: 0 ns', file=f)
            return

        keys = self._ids
        vals = self._vals
        vals_ns = vals / freq_mhz * 1000
        min_tid = np.amin(keys)
        max_tid = np.amax(keys)

        min_ts = np.amin(vals_ns)
        max_ts = np.amax(vals_ns)
        avg_ts = np.mean(vals_ns)
        std_ts = np.std(vals_ns)

        print('--------------------------------', file=f)
        print(f'TimestampStat({name}): id range = [0x{min_tid:08x}:0x{max_tid:08x}]', file=f)
        print(f'Minimum Timestamp: {min_ts:.2f} ns', file=f)
        print(f'Maximum Timestamp: {max_ts:.2f} ns', file=f)
        print(f'Average Timestamp: {avg_ts:.2f} ns', file=f)
        print(f'Stddev Timestamp: {std_ts:.2f} ns', file=f)

    def save_to_csv(self, csv_name):
        """Save timestamps to csv file.

        The header of csv is "timestamp_id,timestamp_val,timestamp_diff".
        The other lines contains 1 timestamp information.

        - timestamp_id: ID of timestmap
        - timestamp_val: timestamp value (cycles)
        - timestamp_diff: The difference of timestamp value from the previous timestamp.

        Args:
            csv_name (str): Output file name.

        Returns:
            None
        """
        with open(csv_name, 'w') as f:
            f.write('timestamp_id,timestamp_val,timestamp_diff\n')
            last = 0
            for k, v in zip(self._ids, self._vals):
                f.write(f'0x{k:08x},{v},{v - last}\n')
                last = v

    def save_to_binary(self, binary_name):
        """Save timestamps to binary file.

        Args:
            filename (str): file of binary file.
                The generated binary file contains 64-bit information per timestamp.
                - ID: 32bit id
                - timestamp: 32bit timestamp (cycles)

        Returns:
            None: none
        """
        # add last axis
        ids = self._ids.reshape(-1, 1)
        vals = self._vals.reshape(-1, 1)

        # create new array
        merged = np.concatenate((ids, vals), axis=1)
        merged.tofile(binary_name)


class EFCapture():
    """This class controls the EFCapture module on FPGA board.
    """

    def __init__(self, xsdb: pyxsdb.PyXsdb, xsdb_target: int, addr_table: TsnEfccAddressTable, port: int, direction=None):

        self.xsdb = xsdb
        self.xsdb_target = xsdb_target
        self.efcc_type = addr_table.efcc_type
        if self.efcc_type == '1g':
            self.tx_ctrl_addr = addr_table.ef_capture_tx_ctrl[port]
            self.rx_ctrl_addr = addr_table.ef_capture_rx_ctrl[port]
            self.ctrl_addr = None
            self.ram_addr = addr_table.ef_capture_buffers[port]
            self.switch_addr = addr_table.ef_capture_buffer_switch[port]
        elif self.efcc_type == '10g':
            if direction == 'rx':
                self.ctrl_addr = addr_table.ef_capture_rx_ctrl[port]
                self.ram_addr = addr_table.ef_capture_buffers[port + 8]
            elif direction == 'tx':
                self.ctrl_addr = addr_table.ef_capture_tx_ctrl[port]
                self.ram_addr = addr_table.ef_capture_buffers[port]
            else:
                raise ValueError(f'Acceptable direction is "rx" or "tx", but got {direction}')
            self.switch_addr = None
        self.commit_hash = addr_table.commit_hash

    def get_status(self) -> Dict[str, int]:
        """get current device status.

        Returns:
            Dict[str, str or int]: Returns a dictionary of status. This dictionary contains the following values:
                - 'status': 'Done (BRAM is full)' or 'Recording timestmaps' (str)
                - 'bramcounter': bram counter value (int)
                - 'framecounter': frame counter value (int)
        """
        self._set_xsdb_target()
        stat = self.xsdb.mrd(self.ctrl_addr + 4)
        fcnt = self.xsdb.mrd(self.ctrl_addr + 8)
        bcnt = self.xsdb.mrd(self.ctrl_addr + 12)

        return {'status': 'Done (BRAM is full)' if (stat & 0x1) == 1 else 'Recording timestamps',
                'bramcounter': bcnt,
                'framecounter': fcnt}

    def select_port(self, direction: str) -> None:
        """Select ports to record timestamps.

        Args:
            direction (str): The direction of port. Acceptable value: "rx" or "tx"

        Returns:
            None: none
        """
        if self.efcc_type == '1g':
            regval = None
            if direction == 'rx':
                regval = 0x2
                self.ctrl_addr = self.rx_ctrl_addr
            elif direction == 'tx':
                regval = 0x1
                self.ctrl_addr = self.tx_ctrl_addr

            if regval is None:
                raise ValueError(f'Acceptable direction is "rx" or "tx", but got {direction}')

            self.xsdb.mwr(self.switch_addr, regval)


    def reset(self, reset_framecounter: bool = True) -> None:
        """Reset EFCapture.

        Args:
            reset_framecounter (bool): Whether if frame counter is reset or not. (default: True)

        Returns:
            None: none
        """
        self._set_xsdb_target()
        if reset_framecounter:
            reset_cmd = 3
        else:
            reset_cmd = 1

        self.xsdb.mwr(self.ctrl_addr, reset_cmd)

    def wait(self, framecounter: int) -> None:
        """Wait until the framecounter exceeds the input frame counter value.

        Args:
            framecounter (int): The frame counter threshold.

        Returns:
            None: none
        """
        self._set_xsdb_target()
        while (True):
            stat = self.xsdb.mrd(self.ctrl_addr + 4)
            fcnt = self.xsdb.mrd(self.ctrl_addr + 8)

            if fcnt >= framecounter:
                return framecounter

            if (stat & 0x1) == 1:
                raise ValueError(f'EFCapture stopped eariler. current frame counter = {fcnt}, expect frame counter {framecounter}')

    def read_timestamp(self, num_timestamps: int, show_progress: bool = True) -> TimestampStatistic:
        """Read timestamp from hardware register, and returns TimestampStatistic object.

        Args:
            num_timestamps (int): The number of timestamps to read.
            show_progress (bool): Toggle progress bar. (default: True (ON))

        Returns:
            TimestampStatistic: The device timestamps
        """
        self._set_xsdb_target()
        stat = TimestampStatistic()
        tids = []
        tvals = []
        for i in range(num_timestamps):
            id_addr = self.ram_addr + i * 8
            ts_addr = id_addr + 4

            tid = self.xsdb.mrd(id_addr)
            tval = self.xsdb.mrd(ts_addr)

            tids.append(tid)
            tvals.append(tval)

            if show_progress and i % 100 == 0:
                self._show_progress_bar('read_timestamp', i, num_timestamps)

        stat.push_list(tids, tvals)

        if show_progress:
            self._show_progress_bar('read_timestamp', num_timestamps, num_timestamps)
            print('')

        return stat

    def get_commit_hash(self) -> int:
        """Get commit hash used to implement the current bitstream

        Args:
            None: none

        Returns:
            int: 8-digit Git commit hash
        """
        hash = self.commit_hash
        self._set_xsdb_target()
        return hex(self.xsdb.mrd(hash))

    def _show_progress_bar(self, title, i, total):
        done_char = '█'
        remain_char = '-'
        bar_len = 30
        filled_len = int(i * bar_len // total)
        bar = done_char * filled_len + remain_char * (bar_len - filled_len)
        sys.stdout.write(f'\r{title}: |{bar}| {i} / {total}')

    def _set_xsdb_target(self):
        self.xsdb.target(self.xsdb_target)
