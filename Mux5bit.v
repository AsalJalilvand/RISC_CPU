module Mux5bit(a, b, out,
sel);
   input [4:0]a;
   input[4:0]b;
   input sel;
   output [4:0]out;
    assign out = sel ? b : a;
endmodule
