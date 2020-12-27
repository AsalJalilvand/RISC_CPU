module IF_Stage(clk,branch,jump,jump_destination,EXMEM_AddResult,IF_ID_IR,IF_ID_NPC);
  input clk;
  input branch;
  input jump;
  input [31:0]EXMEM_AddResult;
  input [31:0]jump_destination; 
  output reg [31:0]  IF_ID_IR;
  output reg [31:0]  IF_ID_NPC;
   
   
  wire [31:0] addr;
  wire [31:0] out;
   reg  [31:0] pc;
   wire [31:0]temp;
   wire[31:0] instruction;
   wire [31:0] pctemp;
   wire [31:0]t;
   //wire jump;
  
 initial 
 begin 
 pc = 1'b0;
 end

   
   always@(posedge clk)
  begin
      
        pc = pctemp;
        IF_ID_IR=instruction;
        IF_ID_NPC=temp; 
        
   
  end

  
 assign temp = pc + 1;

  
  Instruction_Memory ins_mem(.addr(pc),.out(instruction)); 
  Mux32bit mux_pc(.a(temp), .b(EXMEM_AddResult), .out(t),.sel(branch)); 
  Mux32bit mux_jump(.a(t),.b(jump_destination),.out(pctemp),.sel(jump));
  
  
endmodule

module IF_Stage_tb();
    // Inputs
    reg clk;
    reg jump;
    reg [31:0]EXMEM_AddResult;
     wire [31:0]  IF_ID_IR;
     wire [31:0]  IF_ID_NPC;
     
     IF_Stage IF(clk,jump,EXMEM_AddResult,IF_ID_IR,IF_ID_NPC);
       
     always #30 clk = ~clk;
    initial
     begin
       
       clk = 0;
      // EXMEM_AddResult=4;
       #30 jump=0;
         
   end
   
 
endmodule
