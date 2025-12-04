
`timescale 1 ps / 1 ps

module tb();
  reg clk;
  reg rst;
  reg [1:0] sel;
  wire [7:0] wave_out;
  
  top_mux dut(clk, rst, sel, wave_out);
  
  always #5 clk = ~clk;
  
  initial begin
    clk = 0; rst = 1; sel = 0;
    #10; rst = 0;
    #10; sel = 1;
    #10; sel = 2;
    #10; sel = 3;
    #10; $finish;
  end
endmodule
