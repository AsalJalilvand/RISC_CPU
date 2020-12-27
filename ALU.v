//`include "INS_DEFINE.v"

module ALU(
	input [31:0] 		in1,
	input [31:0] 		in2,
	input [3:0]			control,
	output reg  [31:0]	out,
	output				zero		
);

	assign zero = (out == 0);
	
	always @(control or in1 or in2)  begin 
		case (control) 
			            4'b0001: out <=  $signed(in1) & $signed(in2); // 1 and
						      4'b0010: out <= $signed(in1) | $signed(in2); // 2 or      
			            4'b0011: out <= $signed(in1) + $signed(in2);  // 3 add               
			            4'b0100: out <= $signed(in1) - $signed(in2);  // 4 sub
			            4'b0101: out <= $signed(in1) < $signed(in2) ? 1 : 0; // 5 slt
			            4'b0110: out <= (~($signed( in1) | $signed(in2))); // 6 nor
			            4'b0111: out <= in1 ^ in2; //7 xor

			default: out <= 0;
		endcase			
	end
	
endmodule	
//--------------------------------------------------------------------------
//`timescale 1ns/1ps
//`include "INS_DEFINE.v"
module tb();

reg [31:0] in1, in2;
reg [3:0] control;
wire [31:0] out;
wire zero;

ALU ALU_ins(    
  .in1(in1),
  .in2(in2),          
  .control(control),
  .out(out),
  .zero(zero)
);

initial begin
  in1 = 32'b0101;
  in2 = 32'b1010;//??32 bit?
  
  control = 4'b0001;
  
  #20 control = 4'b0010;
  
  #20 control = 4'b0100;
  
    
end

endmodule

