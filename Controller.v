//`timescale 1ns / 1ps
//`include "MIPS_DEFINES.v"	

module Controller
(
  opcode,
  regDst,
  jump ,
  beq,
  bne,
  memRead,
  memToReg,
  aluOp,
  memWrite,
  aluSrc,
  regWrite 
);
  input [31:26]	opcode; //changed from [31:0] to [31:26] only opcode
  
  output reg regDst;
  output reg memToReg;
  output reg aluSrc;
  output reg jump;
  output reg beq;
  output reg bne;
  output reg memRead;
  output reg memWrite;
  output reg regWrite;
  output reg [2:0] aluOp;



 
  //---------------------------------------------------------------
  // Combinatorial Logic
  //---------------------------------------------------------------
 
initial
begin
beq=0;
bne=0;
jump=0;
end 
  always @(opcode) 
  begin
		
    if (opcode == 6'b000000) // R format
		begin 	  
			 regDst = 1'b1;
			 aluSrc = 1'b0;
			 memToReg = 1'b0;
			 regWrite = 1'b1;
			 memRead = 1'b0;
			 memWrite = 1'b0;
			 beq = 1'b0;
			 bne = 1'b0;
			 jump = 1'b0;
			 aluOp[0] = 1'b0;
			 aluOp[1] = 1'b1;
			 aluOp[2] = 1'b1;
			 	  
		end
	else if (opcode == 6'b000010) // J format jump 
		begin 
			 regWrite = 1'b0;
			 memRead = 1'b0;
			 memWrite = 1'b0;
			 beq = 1'b0;
			 bne = 1'b0;
			 jump = 1'b1;
		end 
	else if (opcode ==6'b000100) //Branch Equal - I type
		begin 
			 aluSrc = 1'b0;
			 regWrite = 1'b0;
			 memRead = 1'b0;
			 memWrite = 1'b0;
			 beq = 1'b1;
			 bne = 1'b0;
			 jump = 1'b0;
			 aluOp[0] = 1'b1;
			 aluOp[1] = 1'b0;
			 aluOp[2] = 1'b0;
			 
		end
	else if(opcode ==6'b000101)//Branch Not Equa - I type
		begin 
			 aluSrc = 1'b0;
			 regWrite = 1'b0;
			 memRead = 1'b0;
			 memWrite = 1'b0;
			 beq = 1'b0;
			 bne = 1'b1;
			 jump = 1'b0;
			 aluOp[0] = 1'b1;
			 aluOp[1] = 1'b0;
			 aluOp[2] = 1'b0;
		end
	else if(opcode == 6'b100011)//Load - I type
		begin 
			 regDst = 1'b0;
			 aluSrc = 1'b1;
			 memToReg = 1'b1;
			 regWrite = 1'b1;
			 memRead = 1'b1;
			 memWrite = 1'b0;
			 beq = 1'b0;
			 bne = 1'b0;
			 jump = 1'b0;
			 aluOp[0] = 1'b0;
			 aluOp[1] = 1'b0;
			 aluOp[2] = 1'b0;
		end
	else if(opcode == 6'b101011)//Store - I type
		begin 
			
			 aluSrc = 1'b1;
			 regWrite = 1'b0;
			 memRead = 1'b0;
			 memWrite = 1'b1;
			 beq = 1'b0;
			 bne = 1'b0;
			 jump = 1'b0;
			 aluOp[0] = 1'b0;
			 aluOp[1] = 1'b0;
			 aluOp[2] = 1'b0;
		end
 
  else if (opcode == 6'b001000) // ADDI 
    begin     
       regDst = 1'b0;
       aluSrc = 1'b1;
       memToReg = 1'b0;
       regWrite = 1'b1;
       memRead = 1'b0;
       memWrite = 1'b0;
       beq = 1'b0;
       bne = 1'b0;
       jump = 1'b0;
       aluOp[0] = 1'b0;
       aluOp[1] = 1'b0;
       aluOp[2] = 1'b0;     
    end

else if (opcode == 6'b001100) // ANDI
 
    begin     
       regDst = 1'b0;
       aluSrc = 1'b1;
       memToReg = 1'b0;
       regWrite = 1'b1;
       memRead = 1'b0;
       memWrite = 1'b0;
       beq = 1'b0;
       bne = 1'b0;
       jump = 1'b0;
       aluOp[0] = 1'b0;
       aluOp[1] = 1'b1;
       aluOp[2] = 1'b0;     
end
else if (opcode == 6'b001101) // ORI
 
    begin     
       regDst = 1'b0;
       aluSrc = 1'b1;
       memToReg = 1'b0;
       regWrite = 1'b1;
       memRead = 1'b0;
        memWrite = 1'b0;
       beq = 1'b0;
        bne = 1'b0;
        jump = 1'b0;
        aluOp[0] = 1'b1;
        aluOp[1] = 1'b1;
        aluOp[2] = 1'b0;     
end
else if(opcode == 6'b001010) // SLTI 
    begin  
       
        regDst = 1'b0;
        aluSrc = 1'b1;
        memToReg = 1'b0;
        regWrite = 1'b1;
        memRead = 1'b0;
        memWrite = 1'b0;
        beq = 1'b0;
        bne = 1'b0;
        jump = 1'b0;
      aluOp[0] = 1'b1;
       aluOp[1] = 1'b0;
        aluOp[2] = 1'b1;     
end
		
	end
  
  
       


 endmodule 
 //-----------------------------------------------------------------------------
 module controller_tb();
    reg [5:0]	opcode; 
        //controller 
    wire regDst;
    wire jump ;
    wire beq;
    wire bne;
    wire memRead;
    wire memToReg;
    wire [2:0]aluOp;
    wire memWrite;
    wire aluSrc;
    wire regWrite;
    
    Controller controller(.opcode(opcode),.regDst(regDst),.jump(jump),.beq(beq),.bne(bne),
                   .memRead(memRead),.memToReg(memToReg),.aluOp(aluOp),.memWrite(memWrite),
                   .aluSrc(aluSrc),.regWrite(regWrite));	
     initial
     begin
     opcode = 6'b000000;
     #20 opcode = 4'd2;
     #20 opcode = 4'd4;
     #20 opcode = 4'd5;
     #20 opcode = 6'b100000;
     #20 opcode = 6'b101000;
   end
     
                   
                   
 endmodule