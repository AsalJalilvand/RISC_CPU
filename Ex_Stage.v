module Ex_Stage(
input IDEX_EX_RegDst,
input IDEX_EX_ALUSrc,
input [0:2] IDEX_EX_ALUOp,

input [31:0] IDEX_NPC,
input [31:0] IDEX_A,//read data 1
input [31:0] IDEX_B ,//read data 2
input [31:0] IDEX_signextend,
input [4:0] IDEX_Rd ,
input [4:0] IDEX_Rt ,
//newly added
input IDEX_WB_MemToReg,
input IDEX_WB_RegWrite,
input IDEX_M_MemWrite,
input IDEX_M_MemRead,
input IDEX_M_Branch,
input IDEX_M_BranchNotEqual,

output EXMEM_WB_MemToReg,
output EXMEM_WB_RegWrite ,
output EXMEM_M_MemWrite,
output EXMEM_M_MemRead,
output EXMEM_M_Branch,
output EXEMEM_M_BranchNotEqual,
//----

output [31:0] EXMEM_ALUOut , 
output [4:0] EXMEM_Rt,
output EXMEM_zero,
output [31:0]EXMEM_AddResult,
output [31:0]EXMEM_B
);

wire [31:0] alu_mux_out;
wire [3:0]acountrol;

Mux32bit alu_mux(.a(IDEX_B), .b(IDEX_signextend), .out(alu_mux_out),
.sel(IDEX_EX_ALUSrc));
 //sel
Mux5bit rt_mux(.a(IDEX_Rt), .b(IDEX_Rd), .out(EXMEM_Rt),
.sel(IDEX_EX_RegDst));//sel

ALU_Control ac(.func(IDEX_signextend[5:0]), .aluop(IDEX_EX_ALUOp), .control(acountrol)); //aluop
ALU a(.in1(IDEX_A),
.in2(alu_mux_out),
.control(acountrol),
.out(EXMEM_ALUOut),
.zero(EXMEM_zero)
);

 //control
Adder addr(.A(IDEX_NPC),.B(IDEX_signextend),.Sum(EXMEM_AddResult));

assign EXMEM_B = IDEX_B;

assign EXMEM_WB_MemToReg = IDEX_WB_MemToReg;
assign EXMEM_WB_RegWrite = IDEX_WB_RegWrite;
assign EXMEM_M_MemWrite=IDEX_M_MemWrite;
assign EXMEM_M_MemRead= IDEX_M_MemRead;
assign EXMEM_M_Branch= IDEX_M_Branch;
assign EXEMEM_M_BranchNotEqual = IDEX_M_BranchNotEqual;

endmodule


module ex_tb();
 reg IDEX_EX_RegDst;
reg IDEX_EX_ALUSrc;
reg [0:2] IDEX_EX_ALUOp;

reg [31:0] IDEX_NPC;
reg [31:0] IDEX_A;//read data 1
reg [31:0] IDEX_B ;//read data 2
reg [31:0] IDEX_signextend;
reg [4:0] IDEX_Rd ;
reg [4:0] IDEX_Rt ;

wire [31:0] EXMEM_ALUOut ; 
wire [4:0] EXMEM_Rt;
wire EXMEM_zero;
wire [31:0]EXMEM_AddResult;

  Ex_Stage ex(.IDEX_EX_RegDst(IDEX_EX_RegDst),
.IDEX_EX_ALUSrc(IDEX_EX_ALUSrc),
.IDEX_EX_ALUOp(IDEX_EX_ALUOp),

.IDEX_NPC(IDEX_NPC),
.IDEX_A(IDEX_A),
.IDEX_B(IDEX_B) ,
.IDEX_signextend(IDEX_signextend),
.IDEX_Rd (IDEX_Rd ),
.IDEX_Rt(IDEX_Rt) ,

.EXMEM_ALUOut (EXMEM_ALUOut), 
.EXMEM_Rt(EXMEM_Rt),
.EXMEM_zero(EXMEM_zero),
.EXMEM_AddResult(EXMEM_AddResult));
  
  
  initial
     begin
 IDEX_EX_RegDst =0;
IDEX_EX_ALUSrc = 0;
IDEX_EX_ALUOp = 3'b000;

IDEX_NPC = 32'b0;
IDEX_A = 32'b0110;//read data 1
IDEX_B = 32'b0111;//read data 2
IDEX_signextend = 32'b0100010;
IDEX_Rd = 5'b001;
IDEX_Rt = 5'b0010;

 
 #70 begin
  IDEX_EX_RegDst =1;
IDEX_EX_ALUSrc = 1;
end

#70  IDEX_EX_ALUOp = 3'b110;     
     end
endmodule