///////////////***************MUX DESIGN CODE***************///////////////
module mux #( parameter WIDTH = 32, DEPTH = 16, SELECT_LINE_DEPTH=4) 
  (input clk,
   input rst,
   input [(WIDTH-1):0] in[(DEPTH-1):0],
   input [(SELECT_LINE_DEPTH-1):0]s,
   output reg [(WIDTH-1):0]out);
  always_ff @(posedge clk or negedge clk) begin
    if(rst) begin
      assign out =0;
    end
    else begin
      assign out=in[s];//s is a 4-bit signal that represents a value from 0 to 15.That maps directly to a valid index in the din array.
    end
  end
endmodule
