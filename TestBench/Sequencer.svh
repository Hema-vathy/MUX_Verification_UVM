/////////////////////*****************SEQUENCER FILE*****************/////////////////////
//class declaration
class mux_sequencer extends uvm_sequencer #(mux_seq_item);
  
  //factory registration
  `uvm_component_utils(mux_sequencer)
  
  mux_sequence seq;
  //constructor
  function new(string name= "mux_sequencer",uvm_component parent);
    super.new(name,parent);
    `uvm_info("mux_sequencer","constructor",UVM_LOW)
  endfunction:new
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq=mux_sequence::type_id::create("seq");
  endfunction:build_phase
endclass
