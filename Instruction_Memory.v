//`include "MIPS_DEFINES.v"

module Instruction_Memory
(input [31:0] addr,output reg [31:0] out);

  reg  [31:0] RAM[31:0];

  initial
    begin
     // addr = 0;
      $readmemh("input.hex",RAM); //.dat
    end

   always @(addr)begin
         out=RAM[addr];
   end    
endmodule

module Instruction_Memory_tb();
    // Inputs
    reg [31:0] addr;   
    wire [31:0] out;
     
     Instruction_Memory uut (
        .addr(addr),          
        .out(out)
    );
  initial 
begin 
   addr = 0; 
   forever #20 addr = addr + 1; 
end     
endmodule

