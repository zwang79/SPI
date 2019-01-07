`timescale 1ns/10ps
`include "spi_slave.v"

module spi_reg_tb();

reg clk;
reg rst_n;

reg spi_clk;
reg spi_cs;
reg spi_mosi;
wire spi_miso;
//wire [7:0] reg_map[0:127];
integer i;
reg [7:0] result;
reg [7:0] state_indication;

spi_reg spi_reg_inst(
.clk(clk),
.rst_n(rst_n),
.spi_clk(spi_clk),
.spi_cs(spi_cs),
.spi_mosi(spi_mosi),
.spi_miso(spi_miso),
.state_indication(state_indication));

always #8 clk <= ~clk;
//always #200 spi_clk <= ~spi_clk;
//always @(posedge spi_clk)
//       #200 spi_mosi <= $random;

task write_reg;
  input [6:0] reg_address;
  input [7:0] data_content;

   begin
     spi_cs <= 1'b1;
     spi_clk <= 1'b0;
     spi_mosi <= 1'b0;

     #170  spi_cs <= 1'b0;
     #200  spi_mosi <= 1'b1;   // this is the header[7] of a write transaction
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= reg_address[6]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= reg_address[5]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= reg_address[4]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= reg_address[3]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= reg_address[2]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= reg_address[1]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= reg_address[0]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= data_content[7]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= data_content[6]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= data_content[5]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= data_content[4]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= data_content[3]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= data_content[2]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= data_content[1]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= data_content[0]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #170  spi_cs <= 1'b1;
           spi_clk <= 1'b0;
           spi_mosi <= 1'b0;
  end

endtask


task read_reg;
  input [6:0] reg_address;
 // output [7:0] data_content;

   begin
     spi_cs <= 1'b1;
     spi_clk <= 1'b0;
     spi_mosi <= 1'b0;

     #170  spi_cs <= 1'b0;
     #200  spi_mosi <= 1'b0;   // this is the header[7] of a read transaction
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= reg_address[6]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= reg_address[5]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= reg_address[4]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= reg_address[3]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= reg_address[2]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= reg_address[1]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_mosi <= reg_address[0]; spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;

     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;
     #100  spi_clk <= ~spi_clk;

     #170  spi_cs <= 1'b1;
           spi_clk <= 1'b0;
           spi_mosi <= 1'b0;
  end

endtask



initial begin
       //$vcdpluson;
       //$vcdplusmemon;
       clk <= 1'b0;
       rst_n <= 1'b0;
       spi_cs <= 1'b1;
       spi_clk <= 1'b0;
       spi_mosi <= 1'b0;
       state_indication <= 8'b1111_1111;
       //forever begin 
       //    #200 spi_clk <= ~spi_clk;
       //end
       //forever begin
       //    #200 spi_mosi <= ~spi_mosi;
       //end
    #100
       rst_n <= 1'b1;
    #910
    #200
     for(i = 0; i <= 15; i = i + 1) begin
        #500 write_reg(i,i);
     end


     for(i = 0; i <= 15; i = i + 1) begin
        #500 read_reg(i);
        //if(result==i)
        //$display("correct in register %d !\n",i);  
     end

    #100000
       $finish;

end
endmodule
