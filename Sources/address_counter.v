`timescale 1 ps / 1 ps

module address_counter (
    input  wire clk,        // Zed board clock
    input  wire rst,        // p16 button on zed board for reset
    output reg [7:0] addr
);

    
    localparam CLK_FREQ = 100_000_000;   // 100 MHz input
    localparam ADDR_FREQ = 1_000_000;    // 1 MHz output
    localparam COUNT_LIMIT = CLK_FREQ / ADDR_FREQ;  
    localparam WIDTH = $clog2(COUNT_LIMIT);         
    
    reg [WIDTH-1:0] counter = 0;
    
    initial addr = 8'd0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            addr <= 0;
        end
        else begin
            if (counter == COUNT_LIMIT - 1) begin
                counter <= 0;
                addr <= addr + 1;
            end
            else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
