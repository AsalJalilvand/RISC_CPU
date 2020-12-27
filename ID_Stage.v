module ID_Stage(
  input [31:0]instruction,
  input clk,
  input [4:0]write_register,
  input [31:0]write_data,
  output [31:0] read_data1,
  output [31:0] read_data2,
  
  //newly added
  input [31:0] IFID_NPC,
  output [31:0] IDEX_NPC,
  
  output  wire[31:0] sign_ext,
  output [4:0]IDEX_Rd,
  output [4:0]IDEX_Rt,
  output [31:0]jump_destination,
  //output [3:0] EX);*/
  output  RegDst,
  output  memToReg,
  output  aluSrc,
  output  jump,
  output  beq,
  output  bne,
  output  memRead,
  output  memWrite,
  input  RegWrite,
  output controlOut_RegWrite,
  output  [2:0] aluOp);
  
  
  
  
  
  Register_File reg_file(.clk(clk),.rd1_addr(instruction[25:21]),.rd1_data(read_data1),
                        .rd2_addr(instruction[20:16]),	.rd2_data(read_data2),	.wr_en(RegWrite),
                         .wr_addr(write_register),.wr_data(write_data) );
  Controller control(
  .opcode(instruction[31:26]),
  .regDst(RegDst),
  .jump(jump) ,
  .beq(beq),
  .bne(bne),
  .memRead(memRead),
  .memToReg(memToReg),
  .aluOp(aluOp),
  .memWrite(memWrite),
  .aluSrc(aluSrc),
  .regWrite(controlOut_RegWrite)
   );

  
  assign sign_ext= { {16{instruction[15]}}, instruction[15:0] }	;
  assign jump_destination={ {6{instruction[25]}}, instruction[25:0] }	;
  assign IDEX_NPC = IFID_NPC;
  assign IDEX_Rt = instruction[20:16];
  assign IDEX_Rd = instruction[15:11];
  
endmodule

 module ID_Stage_tb();
  reg clk;
  reg [31:0]instruction;
  
  reg [4:0]write_register;
  reg [31:0]write_data;
  wire [31:0]read_data1;
  wire [31:0]read_data2;
  
  wire[31:0] sign_ext;
  /*output [1:0]WB,
  output [2:0]M,
  output [3:0] EX);*/
  wire RegDst;
 
  wire  memToReg;
  wire  aluSrc;
  wire  jump;
  wire  beq;
  wire  bne;
  wire  memRead;
  wire  memWrite;
  reg  RegWrite;
  wire   controlOut_RegWrite;
  wire  [2:0] aluOp;
  ID_Stage ID(instruction,clk,write_register,write_data,read_data1,read_data2,sign_ext,RegDst,memToReg,aluSrc,jump,
beq,bne,memRead,memWrite,RegWrite,controlOut_RegWrite,aluOp);

   
     always #30 clk = ~clk;
    
   initial begin
     clk=0;
     write_register <= 5'b00010;
     write_data<= 32'b1000;
     RegWrite <= 1'b1;
 
    //#65 RegWrite <= 1'b0;
 
    #65 
    begin
    write_register  <= 5'b00011;
    write_data <= 32'b0101;
  end
 
    #65 
    begin
     RegWrite <= 1'b0;
    write_register<= 5'b00000;
    write_data <= 32'b0;
    instruction <=32'b00000000011000101000000000000000;
  end
end
   
endmodule
