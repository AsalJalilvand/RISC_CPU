module CPU_Core( // Datapath of CPU  
	input clk	
);

//IF/ID output wire---------------------------------
wire [31:0]if_IR;
wire [31:0]if_ID_NPC;

//ID/EX output wire---------------------------------
wire [31:0]read_data1;
wire [31:0]read_data2;
wire [31:0] sign_ext;
wire [31:0] jump_destination;
wire  [4:0]idex_rt;
wire  [4:0]idex_rd;
wire  RegDst;
wire  memToReg;
wire  aluSrc;
wire  jump;
wire  beq;
wire  bne;
wire  memRead;
wire  memWrite;
wire  RegWrite;
wire [2:0] aluOp;
//newly added
wire [31:0]idex_npc;

//EX/MEM output wire---------------------------------
wire [31:0]em_aluout;
wire [4:0]em_Rt;
wire em_zero;
wire [31:0]em_AddResult;
wire [31:0]em_B;
wire exmem_wb_MemToReg;
wire exmem_wb_RegWrite ;
wire exmem_m_MemWrite;
wire exmem_m_MemRead;
wire exmem_m_Branch;
wire exmem_m_BranchNotEqual;

//MEM/WB output wire---------------------------------
wire [4:0]mw_Rt;
wire [31:0]mw_readData;
wire [31:0]mw_ALUOut;
wire pcsrc;
wire memwb_wb_MemToReg;
wire memwb_wb_RegWrite;

//WB output wire---------------------------------
wire [31:0]write_data;

//IF/ID register---------------------------------
reg [31:0] IF_ID_IR;
reg [31:0] IF_ID_NPC;

//ID/EX register---------------------------------
reg IDEX_WB_MemToReg;
reg IDEX_WB_RegWrite;
reg IDEX_M_MemWrite;
reg IDEX_M_MemRead;
reg IDEX_M_Branch;
reg IDEX_M_BranchNotEqual;
reg IDEX_EX_RegDst;
reg IDEX_EX_ALUSrc;
reg [0:2] IDEX_EX_ALUOp;
reg [4:0] IDEX_Rd ;
reg [4:0] IDEX_Rt;
reg [31:0] IDEX_NPC;
reg [31:0] IDEX_signextend;
reg [31:0] IDEX_A;
reg [31:0] IDEX_B;



//EX/MEM register---------------------------------
reg EXMEM_WB_MemToReg ;
reg EXMEM_WB_RegWrite ;
reg EXMEM_M_MemWrite;
reg EXMEM_M_MemRead;
reg EXMEM_M_Branch;
reg EXEMEM_M_BranchNotEqual;
reg [31:0]EXMEM_ALUOut; 
reg [4:0]EXMEM_Rt;
reg EXMEM_zero;
reg [31:0]EXMEM_AddResult;
reg [31:0]EXMEM_B;

//MEM/WB register---------------------------------
reg MEMWB_WB_MemToReg ;
reg MEMWB_WB_RegWrite;
reg [4:0]MemWB_Rt;
reg [31:0]MemWB_readData;
reg [31:0]MemWB_ALUOut;

IF_Stage fetch(.clk(clk),
.branch(pcsrc),
.jump(jump),
.jump_destination(jump_destination),
.EXMEM_AddResult(EXMEM_AddResult),
.IF_ID_IR(if_IR),
.IF_ID_NPC(if_ID_NPC));

ID_Stage id(
  .instruction(IF_ID_IR),
  .clk(clk),
  .RegWrite(MEMWB_WB_RegWrite),
  .read_data1(read_data1),
  .read_data2(read_data2),
  .sign_ext(sign_ext),
  .jump_destination(jump_destination),
  .IDEX_Rd(idex_rd) ,
  .IDEX_Rt(idex_rt) ,
  .RegDst(RegDst),
  .memToReg(memToReg),
  .aluSrc(aluSrc),
  .jump(jump),
  .beq(beq),
  .bne(bne),
  .memRead(memRead),
  .memWrite(memWrite),
  .controlOut_RegWrite(RegWrite),
  .aluOp(aluOp), 
  .write_register(MemWB_Rt),
  .write_data(write_data),
  //newly added
  .IDEX_NPC(idex_npc),
  .IFID_NPC(IF_ID_NPC)
  );

Ex_Stage ex(
.IDEX_EX_RegDst(IDEX_EX_RegDst),
.IDEX_EX_ALUSrc(IDEX_EX_ALUSrc),
.IDEX_EX_ALUOp(IDEX_EX_ALUOp),
.IDEX_NPC(IDEX_NPC),
.IDEX_A(IDEX_A),
.IDEX_B(IDEX_B) ,
.IDEX_signextend(IDEX_signextend),
.IDEX_Rd(IDEX_Rd) ,
.IDEX_Rt(IDEX_Rt) , 
.EXMEM_ALUOut(em_aluout) , 
.EXMEM_Rt(em_Rt),
.EXMEM_zero(em_zero),
.EXMEM_AddResult(em_AddResult),
.EXMEM_B(em_B),
//newly added
.IDEX_WB_MemToReg(IDEX_WB_MemToReg),
.IDEX_WB_RegWrite(IDEX_WB_RegWrite),
.IDEX_M_MemWrite(IDEX_M_MemWrite),
.IDEX_M_MemRead(IDEX_M_MemRead),
.IDEX_M_Branch(IDEX_M_Branch),
.IDEX_M_BranchNotEqual(IDEX_M_BranchNotEqual),
.EXMEM_WB_MemToReg(exmem_wb_MemToReg),
.EXMEM_WB_RegWrite (exmem_wb_RegWrite),
.EXMEM_M_MemWrite(exmem_m_MemWrite),
.EXMEM_M_MemRead(exmem_m_MemRead),
.EXMEM_M_Branch(exmem_m_Branch),
.EXEMEM_M_BranchNotEqual(exmem_m_BranchNotEqual)
);

Mem_Stage mem(
.clk(clk),
.EXMEM_M_MemWrite(EXMEM_M_MemWrite),
.EXMEM_M_MemRead(EXMEM_M_MemRead),
.EXMEM_M_Branch(EXMEM_M_Branch),
.EXEMEM_M_BranchNotEqual(EXEMEM_M_BranchNotEqual),
.EXMEM_zero(EXMEM_zero),
.EXMEM_ALUOut(EXMEM_ALUOut) , 
.EXMEM_B(EXMEM_B),
.MemWB_readData(mw_readData),
.PCSrc(pcsrc),
//newly added
.EXMEM_WB_MemToReg(EXMEM_WB_MemToReg),
.EXMEM_WB_RegWrite(EXMEM_WB_RegWrite),
.EXMEM_Rt(EXMEM_Rt),
.MEMWB_WB_MemToReg(memwb_wb_MemToReg),
.MEMWB_WB_RegWrite(memwb_wb_RegWrite),
.MemWB_Rt(mw_Rt),
.MemWB_ALUOut(mw_ALUOut)
);

WB_Stage wb(
.MemWB_WB_MemToReg(MEMWB_WB_MemToReg) ,
.MemWB_readData(MemWB_readData),
.MemWB_ALUOut(MemWB_ALUOut),
.WB_writeData(write_data)
);


initial
begin 
  EXMEM_M_Branch =0;
  IDEX_M_Branch =0;
  EXEMEM_M_BranchNotEqual =0;
  IDEX_M_BranchNotEqual =0;
end

always@(posedge clk)
#10
begin

//IF/ID register---------------------------------
IF_ID_IR = if_IR;
IF_ID_NPC = if_ID_NPC;

//ID/EX register---------------------------------
IDEX_NPC=idex_npc; //check
//IDEX_NPC = IF_ID_NPC;

IDEX_signextend=sign_ext ;
IDEX_Rd = idex_rd;
IDEX_Rt = idex_rt;
IDEX_A=read_data1;
IDEX_B=read_data2;
IDEX_WB_MemToReg = memToReg;
IDEX_WB_RegWrite = RegWrite;
IDEX_M_MemWrite = memWrite;
IDEX_M_MemRead=memRead;
IDEX_M_Branch=beq;
IDEX_M_BranchNotEqual = bne;
IDEX_EX_RegDst=RegDst;
IDEX_EX_ALUSrc=aluSrc;
IDEX_EX_ALUOp=aluOp;

//EX/MEM register---------------------------------

//check---
EXMEM_WB_MemToReg = exmem_wb_MemToReg;
EXMEM_WB_RegWrite = exmem_wb_RegWrite;
EXMEM_M_MemWrite=exmem_m_MemWrite;
EXMEM_M_MemRead= exmem_m_MemRead;
EXMEM_M_Branch= exmem_m_Branch;
EXEMEM_M_BranchNotEqual = exmem_m_BranchNotEqual;
//---

EXMEM_B = em_B;
EXMEM_ALUOut = em_aluout; 
EXMEM_Rt = em_Rt;
EXMEM_zero = em_zero;
EXMEM_AddResult = em_AddResult;

//MEM/WB register---------------------------------
MEMWB_WB_MemToReg =memwb_wb_MemToReg;
MEMWB_WB_RegWrite =memwb_wb_RegWrite;
MemWB_Rt=mw_Rt;
MemWB_ALUOut=mw_ALUOut;
MemWB_readData = mw_readData;

end
endmodule

