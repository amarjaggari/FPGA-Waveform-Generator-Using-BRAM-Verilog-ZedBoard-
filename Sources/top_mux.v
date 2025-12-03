`timescale 1 ps / 1 ps

module top_mux
   (clk,
    rst,
    sel,           
    wave_out);     

  input clk;    // y9 external clock
  input rst;      //to p16 push button
  input [1:0] sel;    //to switches    
  output [7:0] wave_out;  //to pmod

  wire [7:0] saw_out;
  wire [7:0] sin_out;
  wire [7:0] sq_out;
  wire [7:0] tri_out;

  design_1_wrapper waveform_gen
       (.clk_0(clk),
        .rst_0(rst),
        .saw_out(saw_out),
        .sin_out(sin_out),
        .sq_out(sq_out),
        .tri_out(tri_out));

  assign wave_out = (sel == 2'b00) ? sin_out :
                    (sel == 2'b01) ? sq_out :
                    (sel == 2'b10) ? tri_out :
                    (sel == 2'b11) ? saw_out:
                    2'b00;  // default

endmodule
