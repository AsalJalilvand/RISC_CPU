module WB_Stage(
input MemWB_WB_MemToReg ,

input [31:0] MemWB_readData,
input [31:0] MemWB_ALUOut,

output [31:0]WB_writeData
);

Mux32bit wb_mux(.b(MemWB_readData), .a(MemWB_ALUOut), .out(WB_writeData),
.sel(MemWB_WB_MemToReg ));

endmodule

module wb_tb();
  reg [31:0]readdata;
  reg memtoreg;
  reg [31:0]aluout;
  wire [31:0]writedata;
  
  
  WB_Stage ws(.MemWB_WB_MemToReg(memtoreg) ,

.MemWB_readData(readdata),
.MemWB_ALUOut(aluout),

.WB_writeData(writedata));
  
  initial
     begin
     
readdata=32'b0101;
memtoreg =0;
aluout=32'b0011;
 
 #70 memtoreg = 1;    
     end
endmodule