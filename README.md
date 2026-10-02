# Bachelor-Thesis-project-Design-implementation-and-testing-of-a-RISC-V-soft-processor-on-FPGA-
## The origin
Basically, this project started as a fun one in order to learn more about digital design and VHDL. It was initially implemented only in simulation with the open-source compiler GHDL on a Linux machine. Then, I've decided to propose it to my Digital Electronics professor, who liked it and gave me a De1-SoC to implement it on real physical hardware.

## The structure of the thesis
The first chapter consists in a complete tutorial of the various tools and the workflow of the Quartus IDE, with a practical example of an Hamming encoder: this little project is in the **codificatorehamming** directory.

The second chapter is a brief tutorial of VHDL, nothin special

The third and the fourth chapters could be summarized by the abstract of the thesis: 
*Design, using VHDL, of a 32-bit pipelined RISC-V CPU capable of executing the full RV32I instruction set, accompanied by various testbenches to evaluate and analyze its operation. The design is synthesized and implemented on an FPGA board using the Quartus environment, with debugging performed via advanced tools such as the TimeQuest Timing Analyzer and Signal Tap Logic Analyzer. Finally, the performance of the implemented CPU is compared with that of the Nios V processor, a soft-core developed by Intel for FPGA devices.*
The custom processor is in the directory called **cpu**, whereas the Nios V implementation is in the **niosv** one.

## The textual files
The entire thesis, written in Italian, is the file called **tesiAmorosini.pdf**. The ppt presentation projected during the proclamation day, which summarized the work and contains videos of the FPGA working correctly is instead called **pptTesiAmorosini.pptx**

## The microarchitecture
![Microarchitecture of the custom processor](cpudia.pdf)
