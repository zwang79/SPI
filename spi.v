`timescale 1ns/10ps

module spi_reg(
	input clk,
	input rst_n,
	input spi_clk,
	input spi_cs,
	input spi_mosi,
	output reg spi_miso,
	input [7:0] state_indication	
	);
reg [7:0] header;
reg [7:0] mem[15:0];
reg [3:0] count;
reg [3:0] countn;
reg pos,neg,last;

always @(posedge clk or negedge rst_n)
begin
  if(~rst_n)
    begin
      spi_miso <= 0;
      header <= 0;
			
			count <= 15;
			last <= 0;
			pos <= 0;
			neg <= 0;
			countn <= 15;
			//dataen=0;
			mem[0] <= 0;
			mem[1] <= 0;
			mem[2] <= 0;
			mem[3] <= 0;
			mem[4] <= 0;
			mem[5] <= 0;
			mem[6] <= 0;
			mem[7] <= 0;
			mem[8] <= 0;
			mem[9] <= 0;
			mem[10] <= 0;
			mem[11] <= 0;
			mem[12] <= 0;
			mem[13] <= 0;
			mem[14] <= 0;
			mem[15] <= 0;
    end
  else if( spi_cs )
		begin
			spi_miso <= 0;
			last <= 0;
			pos <= 0;
			neg <= 0;
			countn <= 15;
			//dataen <=0;
			header <= 0;
			
			count <= 15;
		end
  else
    begin
     
      if(last==0 && spi_clk==1)
        begin
          pos<=1;
          neg<=0;
        end
      else if(last==1 && spi_clk==0)
        begin
          pos<=0;
          neg<=1;
        end
      else
        begin
          pos<=0;
          neg<=0;
        end
      last <= spi_clk;
      if(pos)
        begin
          if(count>=8 )//&& dataen)
            begin
              header[count-8] <= spi_mosi;
              count <= count-1;
            end
          else if(count<8 && count>=0 )//&& dataen)
            begin
              if(header[7]==1)
                begin
                  mem[header[3:0]][count] <= spi_mosi;
                  count <= count-1;
                end
              else
                begin
                  
                  count <= count-1;
                end  
            end     
        end
      else if(neg)
        begin
          if(header[7]==1)
            begin
		countn <= countn - 1;
              //if(count==0)
               // mem[header[3:0]] <= data;
 
	      if(countn>=8)
                spi_miso <= state_indication[countn-8];
	      else
		spi_miso <= 0;
            end
          else
            begin
		countn <= countn - 1;
              if(countn>=8)
                spi_miso <= state_indication[countn-8];
	      else
		spi_miso <= mem[header[3:0]][countn];
            end
        end
    end
end
endmodule
