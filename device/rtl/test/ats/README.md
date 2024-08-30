# test/ats

This directory containts test files for ATS modules.

## Run test

```bash
$ cd <repository_top>
$ bash build_device.sh run_tb_ats_modules
```

## Display waveforms

```bash
$ cd <repository_top>
$ bash build_device.sh display_<test_name>
ex) $ bash build_device.sh display_tb_separate_timestamp.ethernet_frame
```

## Required environment

- Python 3.8.10
- Scapy 2.4.3
- Icarus Verilog version 10.3 (stable)
- GTKWave Analyzer v3.3.103
