module Mem_Stage
(
input clk,

input EXMEM_M_MemWrite,
input EXMEM_M_MemRead,
input EXMEM_M_Branch,
input EXEMEM_M_BranchNotEqual,

input EXMEM_zero,
input [31:0] EXMEM_ALUOut , 
input [31:0]EXMEM_B,
//newly added
input EXMEM_WB_MemToReg,
input EXMEM_WB_RegWrite,
input [4:0] EXMEM_Rt,

output MEMWB_WB_MemToReg,
output MEMWB_WB_RegWrite,
output [4:0] MemWB_Rt,
output [31:0] MemWB_ALUOut,
//--
output [31:0] MemWB_readData,
output PCSrc
);

/*initial
begin
  PCSrc = 0;
end*/
 //assign PCSrc = EXMEM_zero & EXMEM_M_Branch;
and b(b1,EXMEM_zero,EXMEM_M_Branch);
and bn(b2,~EXMEM_zero,EXEMEM_M_BranchNotEqual);
or(PCSrc,b1,b2);

Data_Memory dm(.clk(clk),.addr(EXMEM_ALUOut),.rd_en(EXMEM_M_MemRead),.out(MemWB_readData),.wr_en(EXMEM_M_MemWrite),.wr_data(EXMEM_B));

assign MEMWB_WB_MemToReg = EXMEM_WB_MemToReg;
assign MEMWB_WB_RegWrite = EXMEM_WB_RegWrite;
assign MemWB_Rt = EXMEM_Rt;
assign MemWB_ALUOut = EXMEM_ALUOut;

endmodule

module mem_tb();
  reg clk;
  reg memwrite;
  reg memread;
  reg branch;
  reg zero;
  reg [31:0]aluout;
  reg [31:0] b;
  wire pcsrc;
  wire [31:0]readdata;
  Mem_Stage ms(.clk(clk),.EXMEM_M_MemWrite(memwrite),.EXMEM_M_MemRead(memread),
.EXMEM_M_Branch(branch),.EXMEM_zero(zero),.EXMEM_ALUOut(aluout) , .EXMEM_B(b),
.MemWB_readData(readdata),.PCSrc(pcsrc));
  
  always #30 clk = ~clk;
  
  initial
     begin
       clk = 0;
 memread = 0;
 memwrite = 1;
 branch = 0;
 zero = 1;
 aluout = 0;
 b = 32'b0011;
 
 #70 begin
 memread = 1;
 memwrite = 0;
 branch = 1;
end     
     end
endmodule