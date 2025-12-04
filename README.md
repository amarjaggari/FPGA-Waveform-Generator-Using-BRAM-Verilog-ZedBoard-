# FPGA-Waveform-Generator-Using-BRAM-Verilog-ZedBoard-
A BRAM-based digital function generator implemented in Verilog on the ZedBoard. Generates sine, square, triangular, and sawtooth waveforms using BRAM lookup tables.
1. Introduction to BRAM-Based Waveform Generation

Waveform generation is a foundational technique used in electronics for producing periodic signals such as sine, square, triangular, and sawtooth waves. Traditional function generators are standalone instruments, but with the rise of FPGA technology, digital waveform generation has become efficient, scalable, and highly customizable.

The BRAM-based waveform generator uses Block RAM inside the FPGA to store digital sample values of a waveform. These samples form a lookup table (LUT) representing one full cycle of the signal. By reading these values sequentially at a controlled clock rate, the FPGA produces repeated periodic waveform output.

This method avoids runtime computation like sin(), cos(), or CORDIC operations. Instead, the waveform is pre-computed and stored in memory, enabling faster and more resource-efficient generation.
2. Why BRAM? (Advantage Over LUTs)

FPGA has two main memory resources:

a) Distributed RAM (LUT-based)

Small, implemented using logic cells.

b) BRAM (Block RAM)

Dedicated memory blocks inside the FPGA fabric with large size and better performance.

Why BRAM is preferred for waveform LUTs

Feature	LUT RAM	BRAM
Storage capacity	Small	Large (KB–MB)
Speed	High	Very high
Best use	Logic functions	Data tables / waveforms
Resources	Uses logic fabric	Dedicated memory cells
