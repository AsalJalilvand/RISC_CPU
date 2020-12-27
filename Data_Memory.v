//`include "MIPS_DEFINES.v"

module Data_Memory(
  input clk,
  input [31:0] addr,
  input rd_en,
  output reg [31:0] out,	
  input  wr_en,	
  input [31:0] wr_data		
);	

reg [31:0] memory [31:0];  // 32 memory cells 

always @(rd_en)
  begin
    if(rd_en == 1) out = memory[addr];
end
 

always @(posedge clk) //write
   begin
    if (wr_en == 1) memory[addr]=wr_data	;
   end
   
   endmodule	
   
   module data_memory_tb();
     reg clk;
     reg[31:0] addr;
     reg rd_en;
    wire [31:0] out;
    reg  wr_en;	
    reg [31:0] wr_data;
     Data_Memory dm(.clk(clk),.addr(addr),.rd_en(rd_en),.out(out),.wr_en(wr_en),	.wr_data(wr_data)	);
     
     always #30 clk = ~clk;
     
     initial
     begin
       clk = 0;
       
  
       wr_en = 1;
       addr = 32'b0;
       wr_data = 32'b00110;
       
     end
   endmodule