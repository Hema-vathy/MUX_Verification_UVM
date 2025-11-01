//////////////////***************SEQUENCE ITEM FILE***************//////////////////
class mux_seq_item #(parameter WIDTH = 32, DEPTH = 16, SELECT_LINE_DEPTH = 4)
  extends uvm_sequence_item;

  // Factory registration for parameterized classes
  `uvm_object_param_utils(mux_seq_item#(WIDTH, DEPTH, SELECT_LINE_DEPTH))

  // Data members
  rand logic clk;
  rand logic rst;
  rand logic [(WIDTH-1):0] in[(DEPTH-1):0];
  rand logic [(SELECT_LINE_DEPTH-1):0] s;
       logic [(WIDTH-1):0] out;

  // Constructor
  function new(string name = "mux_seq_item");
    super.new(name);
    `uvm_info("mux_seq_item", "Constructor called", UVM_LOW)
  endfunction

endclass
