# FPGA-Waveform-Generator-Using-BRAM-Verilog-ZedBoard-
A BRAM-based digital function generator implemented in Verilog on the ZedBoard. Generates sine, square, triangular, and sawtooth waveforms using BRAM lookup tables.
1. Introduction to BRAM-Based Waveform Generation

Waveform generation is a foundational technique used in electronics for producing periodic signals such as sine, square, triangular, and sawtooth waves. Traditional function generators are standalone instruments, but with the rise of FPGA technology, digital waveform generation has become efficient, scalable, and highly customizable.

The BRAM-based waveform generator uses Block RAM inside the FPGA to store digital sample values of a waveform. These samples form a lookup table (LUT) representing one full cycle of the signal. By reading these values sequentially at a controlled clock rate, the FPGA produces repeated periodic waveform output.

This method avoids runtime computation like sin(), cos(), or CORDIC operations. Instead, the waveform is pre-computed and stored in memory, enabling faster and more resource-efficient generation.

**#2. Why BRAM? (Advantage Over LUTs)**

FPGA has two main memory resources:

a) Distributed RAM (LUT-based)

Small, implemented using logic cells.

b) BRAM (Block RAM)

Dedicated memory blocks inside the FPGA fabric with large size and better performance.

| Feature          | LUT RAM           | BRAM                    |
| ---------------- | ----------------- | ----------------------- |
| Storage capacity | Small             | Large (KB–MB)           |
| Speed            | High              | Very high               |
| Best use         | Logic functions   | Data tables / waveforms |
| Resources        | Uses logic fabric | Dedicated memory cells  |

**#Getting COE Files from Python for BRAM Initialization**

What is a COE File?

A COE (Coefficient) file is a text file format used by Xilinx/AMD FPGA tools to initialize Block RAM (BRAM) or ROM contents. It specifies the initial memory values that get loaded into BRAM when the FPGA configuration is loaded.

**Basic COE File Format**

memory_initialization_radix=16;   // 16 means hex, 10 means decimal
memory_initialization_vector=
00,04,0A,10,1F,3A,55,6F,7F,...;

  
#Why Generate COE Files from Python?


i.Dynamic data generation (sine waves, filters, LUTs)

ii.Preprocessing complex data (images, audio samples)

iii.Algorithmic pattern generation

iv.Test vector creation
** **Generating COE Using Python****

We mathematically generate a waveform (example: 8-bit sine wave of 256 samples)

Python Code Example:
import math

N = 256                       # number of samples
bits = 8                      # amplitude resolution (0–255)
file = open("sine256.coe","w")

file.write("memory_initialization_radix=16;\n")
file.write("memory_initialization_vector=\n")

for i in range(N):
    value = int((math.sin(2*math.pi*i/N)+1)*127.5)   # convert -1..1 → 0..255
    file.write(f"{value:02X}")
    if i < N-1:
        file.write(",")   # comma between values
file.write(";")
file.close()

4. How Vivado Uses .coe to Store Data in BRAM
Steps in Vivado:

Open IP Catalog → Block Memory Generator

Set memory depth = 256, width = 8 bits

Browse → load sine256.coe

Generate output product

Connect BRAM output dout to your wave player logic

Now the BRAM contains:

Address	Stored Value (from .coe)
0x00	00
0x01	04
0x02	0A
0x03	...
...	...
0xFF	Last sample
 5. How Data Is Accessed Inside BRAM

BRAM acts like a digital memory table.

Address lines → select which sample to output
addr = 0 → output sample 0
addr = 1 → output sample 1
addr = 2 → output sample 2
...
addr = 255 → output sample 255 → wrap to 0


Inside FPGA:

Counter/DDS → Address → BRAM → Sample Out → DAC/PWM

ASCII Internal View
+----------+--------+
| Address  | Value  |
+----------+--------+
|   00     | 0x00   |
|   01     | 0x04   |
|   02     | 0x0A   |
|   03     | 0x10   |
|   ...    | ...    |
|   FF     | 0x7E   |
+----------+--------+


Each clock cycle updates the address, so values stream out sequentially, generating waveform.
