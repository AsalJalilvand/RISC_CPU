module Mux32bit(a, b, out,
sel);
   
   input [31:0]a;
   input[31:0]b;
   input sel;
   output [31:0]out;
  // initial
  // begin
   //  out = 0;
  // end
  
   assign out = sel ? b : a;
endmodule

module mux_test();
  reg [31:0] a;
  reg [31:0] b;
  reg sel;
  wire [31:0]out;
  Mux32bit mux(.a(a),.b(b),.out(out),.sel(sel));
  
  initial
  begin
  a=4'd7;
  b=4'd3;
  sel=1'd1;
  #500 sel = 1'd0;
  #100 sel=1'd1;
end
  
endmodule