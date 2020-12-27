
`define CYCLE_TIME 50

// Write your code here. You can modify all of the codes

module Test_Bench();
  
  reg         clk;	
  integer     i,outfile;
  
  always #(`CYCLE_TIME/2) clk = ~clk;    

  CPU_Core CPU(
      .clk  (clk)			
      );
    
  initial begin
 
   
   for(i = 0; i< 32; i = i+1) 
   begin
			CPU.id.reg_file.register[i] = 0 ;
			CPU.mem.dm.memory[i] =0;			
	 end
	
    outfile = $fopen("output.txt") | 1;    	
    clk = 0;		
    
   #(`CYCLE_TIME/4);			
    
  end
  
  always@(posedge clk) begin

    // print PC
   $fdisplay(outfile, "PC = %d",CPU.fetch.pc);
    
    // print Registers
    $fdisplay(outfile, "Registers");
    $fdisplay(outfile, "R0(r0) =%d, R8 (t0) =%d, R16(s0) =%d, R24(t8) =%d", CPU.id.reg_file.register[0], CPU.id.reg_file.register[8] , CPU.id.reg_file.register[16], CPU.id.reg_file.register[24]);
    $fdisplay(outfile, "R1(at) =%d, R9 (t1) =%d, R17(s1) =%d, R25(t9) =%d", CPU.id.reg_file.register[1], CPU.id.reg_file.register[9] , CPU.id.reg_file.register[17], CPU.id.reg_file.register[25]);
    $fdisplay(outfile, "R2(v0) =%d, R10(t2) =%d, R18(s2) =%d, R26(k0) =%d", CPU.id.reg_file.register[2], CPU.id.reg_file.register[10], CPU.id.reg_file.register[18], CPU.id.reg_file.register[26]);
    $fdisplay(outfile, "R3(v1) =%d, R11(t3) =%d, R19(s3) =%d, R27(k1) =%d", CPU.id.reg_file.register[3], CPU.id.reg_file.register[11], CPU.id.reg_file.register[19], CPU.id.reg_file.register[27]);
    $fdisplay(outfile, "R4(a0) =%d, R12(t4) =%d, R20(s4) =%d, R28(gp) =%d", CPU.id.reg_file.register[4], CPU.id.reg_file.register[12], CPU.id.reg_file.register[20], CPU.id.reg_file.register[28]);
    $fdisplay(outfile, "R5(a1) =%d, R13(t5) =%d, R21(s5) =%d, R29(sp) =%d", CPU.id.reg_file.register[5], CPU.id.reg_file.register[13], CPU.id.reg_file.register[21], CPU.id.reg_file.register[29]);
    $fdisplay(outfile, "R6(a2) =%d, R14(t6) =%d, R22(s6) =%d, R30(s8) =%d", CPU.id.reg_file.register[6], CPU.id.reg_file.register[14], CPU.id.reg_file.register[22], CPU.id.reg_file.register[30]);
    $fdisplay(outfile, "R7(a3) =%d, R15(t7) =%d, R23(s7) =%d, R31(ra) =%d", CPU.id.reg_file.register[7], CPU.id.reg_file.register[15], CPU.id.reg_file.register[23], CPU.id.reg_file.register[31]);

    // print Data Memory
   /* $fdisplay(outfile, "Data Memory: 0x00 =%d", CPU.mem.dm.memory[0]);
    $fdisplay(outfile, "Data Memory: 0x01 =%d", CPU.mem.dm.memory[1]);
    $fdisplay(outfile, "Data Memory: 0x02 =%d", CPU.mem.dm.memory[2]);
    $fdisplay(outfile, "Data Memory: 0x03 =%d", CPU.mem.dm.memory[3]);
    $fdisplay(outfile, "Data Memory: 0x04 =%d", CPU.mem.dm.memory[4]);
    $fdisplay(outfile, "Data Memory: 0x05 =%d", CPU.mem.dm.memory[5]);
    $fdisplay(outfile, "Data Memory: 0x06 =%d", CPU.mem.dm.memory[6]);
    $fdisplay(outfile, "Data Memory: 0x07 =%d", CPU.mem.dm.memory[7]);*/
  
    $fdisplay(outfile, "\n");
    
  end

  
endmodule

