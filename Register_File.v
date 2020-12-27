module Register_File (
  input clk,
  
  input [4:0] rd1_addr,
  output reg[31:0] rd1_data,
  
  input [4:0] rd2_addr,	
  output reg[31:0] rd2_data,	
  
  input wr_en, 
  input [4:0] wr_addr,
  input [31:0] wr_data 	
);	

reg signed [31:0] register [0:31];//32 32-bit register

always @(negedge clk)
#10 begin
  assign rd1_data = register[rd1_addr];
  assign rd2_data = register[rd2_addr];
end



always @(negedge clk)//write only on the positive edge of clock
  begin
    if (wr_en == 1) begin
    register[wr_addr] = wr_data;
  end
  end
  
 
 
  
endmodule
//-----------------------------------------------------------------------------
module Register_File_tb();
 
reg clk; 
reg wr_en;
reg [5:0] rd1_addr, rd2_addr, wr_addr;
wire [31:0] rd1_data, rd2_data;
reg [31:0] wr_data ;
reg [31:0]r1;
reg [31:0]r2;
 
    Register_File file1(.clk(clk),.wr_en(wr_en), .rd1_addr(rd1_addr), .rd2_addr(rd2_addr),
        .wr_addr(wr_addr), .rd1_data(rd1_data), .rd2_data(rd2_data), .wr_data(wr_data));
 
 always #30 clk = ~clk;
 
 
 
initial begin
  clk = 0;
  rd1_addr <= 5'b00010;
    rd2_addr <= 5'b00011;
        #30
        begin
    wr_addr <= 5'b00010;
    wr_data <= 32'b1000;
    wr_en <= 1'b1;
  end
 
  
 
    #60 begin
    wr_addr  <= 5'b00011;
    wr_data <= 32'b0101;
    end
 
 
end
  always@(posedge clk)
    begin
      r1=rd1_data;
      r2=rd2_data;
    end
endmodule     
 
 
 
 
 
