`timescale 1ns/10ps

module spi_mem(
	input  wire clk,
	input  wire rst_n,
	input  wire write,
	input  wire read,
	input  wire [3:0] address,
  input  wire [7:0] data_in,
	output reg  [7:0] data_out
	);

integer i;
reg [7:0] mem[0:15];


always @(posedge clk or negedge rst_n) begin
  if(!rst_n) begin
    for (i = 0; i <= 15; i = i + 1) mem[i] <= 8'b0;
    data_out <= 8'b0;
  end
  else begin
    mem[address] <= write?data_in:mem[address];
    data_out     <= read?mem[address]:8'b0;
  end
end
endmodule
