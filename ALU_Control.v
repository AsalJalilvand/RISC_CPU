//`include "INS_DEFINE.v"
module ALU_Control(func, aluop, control);
input [5:0] func;
input [2:0]aluop; 
output reg[3:0] control;
always@(func or aluop)
begin

if(aluop == 3'b110) // R-type
	begin
	case(func)
	6'b100010 : control = 4'b0100  ; //subtraction
	6'b100000 : control = 4'b0011 ; //addition
	
	6'b100100 : control = 4'b0001; //and
	6'b100101 : control = 4'b0010; //or
	6'b100111 : control = 4'b0110 ; //nor 
	6'b101010: control =  4'b0101 ; //slt
	endcase
	end

else if (aluop == 3'b000) // I-type store load
	begin
	control = 4'b0011; //addition
	end

else if (aluop == 3'b000) // I-type ADDI
	begin
	  control = 4'b0011 ; //addition
	end

else if (aluop == 3'b010) // I-type ANDI
	begin
	  control = 4'b0001 ; //and
	end

else if (aluop == 3'b011) // I-type ORI
	begin
	  control = 4'b0010 ; //or
	end

else if (aluop == 3'b101) // I-type SLTI
	begin
	  control = 4'b0101 ; //slt
	end

else if(aluop == 3'b001) // I-type branch and bne 
	begin
	   control = 4'b0100 ; //subtraction
	end

end
endmodule

module alu_control_tb();
  reg [5:0]func;
  reg [2:0]aluop;
  wire [3:0]control;
  ALU_Control a(.func(func),.aluop(aluop),.control(control));
  
  initial
  begin
    aluop = 3'b011;
    
  end
endmodule
