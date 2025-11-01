////////////////*****************INTERFACE FILE*****************////////////////
interface mux_if(); 
  parameter int WIDTH =32;
  parameter int DEPTH =16;
  parameter int SELECT_LINE_DEPTH=4;
  
  logic clk;
  logic rst;
  logic [(WIDTH-1):0] in[(DEPTH-1):0];
  logic [(SELECT_LINE_DEPTH-1):0]s;
  logic [(WIDTH-1):0]out;
  
endinterface
