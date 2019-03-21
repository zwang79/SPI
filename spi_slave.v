`timescale 1ns/10ps
`include "spi_control.v"
`include "spi_mem.v"

module spi_reg(
	input wire clk,
	input wire rst_n,
	input wire spi_clk,
	input wire spi_cs,
	input wire spi_mosi,
	output reg spi_miso,
	input wire [7:0] state_indication	
	);

// internal signals
wire [3:0] address;
wire [7:0] data_in;
wire [7:0] data_out;
wire write, read;

spi_control control (.clk(clk), 
                     .rst_n(rst_n), 
                     .spi_clk(spi_clk),
                     .spi_cs(spi_cs),
                     .spi_mosi(spi_mosi),
                     .spi_miso(spi_miso),
                     .state_indication(state_indication),
                     .data_in(data_in),
                     .data_out(data_out),
                     .address(address),
                     .write(write),
                     .read(read)
                    );

spi_mem memory      (.clk(clk), 
                     .rst_n(rst_n),
                     .write(write),
                     .read(read), 
                     .address(address),
                     .data_in(data_in),
                     .data_out(data_out)
                    );

endmodule
