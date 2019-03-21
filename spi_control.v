`timescale 1ns/10ps

module spi_control(
  // external signals
  input  wire clk,
  input  wire rst_n,
  input  wire spi_clk,
  input  wire spi_cs,
  input  wire spi_mosi,
  output reg  spi_miso,
  input  wire [7:0] state_indication,

  // internal signals
  output reg  [7:0] data_in,
  input  wire [7:0] data_out,
  output reg  [3:0] address,
  output reg  write,
  output reg  read
  );

reg r_w;
reg [3:0] count;
reg pos,neg,last;

// spi_clk edge detector
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin		
			last <= 0;
			pos <= 0;
			neg <= 0;
  end
  else begin
      if (last==0 && spi_clk==1) begin
           pos<=1;
           neg<=0;
         end
         else if (last==1 && spi_clk==0) begin
                pos<=0;
                neg<=1;
              end
              else begin
                pos<=0;
                neg<=0;
              end
         last <= spi_clk;
       end
  end

  // count logic
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n || spi_cs) count <= 4'd0;
    else if (neg) count <= (count < 4'd15)?(count + 4'd1):4'd0;
  end

  // sequential parallel converter
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n || spi_cs) begin
      data_in <= 8'b0;
      spi_miso <= 0;
      r_w <= 0;
    end
    else if (pos) begin
      r_w <= (count == 0)?spi_mosi:r_w;

      // address
      if ((count >= 4'd4) && (count <= 4'd7)) address[4'd7 - count] <= spi_mosi;

      // write data_in
      else if ((count >= 4'd8) && (count <= 4'd15)) data_in[4'd15 - count] <= (r_w == 1)?spi_mosi:data_in[4'd15 - count]; 
    end
    else if (neg) begin
      // state indication
      if (count <= 4'd7) spi_miso <= state_indication[4'd7 - count];
      // read data_out
      else spi_miso <= r_w?0:data_out[4'd15 - count];      
    end
  end

  // write read flag
  always @(posedge clk or negedge rst_n) begin
  if (!rst_n || spi_cs) begin
    read <= 0;
    write <= 0;
  end
  else begin
    if (count == 4'd7) begin
      if (!r_w) read <= (pos)?1:read;
    end
    else if (count == 4'd15) begin
      if (!r_w) read  <= (neg)?0:read;
      else begin
        if (write) write <= (neg)?0:write;
        else write <= (pos)?1:write;
      end
    end 
  end
  end


endmodule
