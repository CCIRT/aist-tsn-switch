# CBS

The [cbs/](cbs/) directory contains the data of the experiments to evaluate credit-based shaping (CBS) of our network switch. It is intended to be informative for those who are developing the network switch using our code and want to see if their switch correctly works.

For details, see our conference paper, which discusses the design of the switch and the results of the experiments. Note that we are continuously improving the implementation and the results in this directory may not be based on the latest implementation.

> FPGA-based Network Switch Architecture Supporting Credit Based Shaper for Time Sensitive Networks, Akram BEN AHMED, Takahiro HIROFUCHI, and Takaaki FUKAI, The 29th IEEE International Conference on Emerging Technologies and Factory Automation (ETFA2024), Sep 2024.

The subdirectories are of the following 7 experiments. See Section V.

1. Clarify the limitation of the measurement tool used in our experiments (i.e., plget)
2. Measure the basic latency of the network switch.
3. Confirm the capability of a CBS traffic class to adjust packet intervals.
4. Confirm strict priority control among traffic classes.
5. Measure the latency of a priority flow competing with a best-effort flow.
6. Measure the latency of the 1st priority flow competing with the 2nd priority flow and the best-effort flow.
7. Measure the latency of the 2nd priority flow competing with the 1st priority flow and the best-effort flow.

# ATS

The [ats/](ats/) directory contains the data of the experiments to evaluate asynchronous traffic shaping (ATS) of our network switch. It is intended to be informative for those who are developing the network switch using our code and want to see if their switch correctly works.

For details, see our journal paper, which discusses the design of the switch and the results of the experiments. Note that we are continuously improving the implementation and the results in this directory may not be based on the latest implementation.

> Hardware design and Evaluation of an FPGA-based Network Switch Supporting Asynchronous Traffic Shaping for Time Sensitive Networking, Akram BEN AHMED, Takahiro HIROFUCHI, and Takaaki FUKAI, IEEE Access, Sep 2024.

The subdirectories are of the following 10 experiments. The experiment 1 to 5 are detailed in Section V of the journal paper. The experiment 6 to 10 are in Section VI.

1. Measure the basic latency of the network switch.
2. Confirm the capability of ATS to control the burst size of a flow.
3. Confirm the capability of ATS to control the transfer rate of an ATS flow.
4. Confirm the capability of ATS to control the transfer rates of multiple ATS flows in one ATS scheduler group (i.e., interleaved regulator).
5. Confirm fixed priority among traffic classes.
6. Measure the latency of an ATS flow competing with a best-effort flow.
7. Measure the latency of 2 ATS flows from different ATS scheduler groups to the same traffic class.
8. Skip.
9. Measure the latency of the 1st priority ATS flow competing with the 2nd priority ATS flow and the best-effort flow.
10. Measure the latency of the 2nd priority flow competing with the 1st priority flow and the best-effort flow.
