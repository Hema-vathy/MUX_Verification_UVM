///////////////////////*******************SCOREBOARD FILE*******************///////////////////////
//class declaration
class mux_scoreboard extends uvm_scoreboard;
  
  //factory registration
  `uvm_component_utils(mux_scoreboard)
  
  uvm_analysis_imp #(mux_seq_item#(32, 16, 4), mux_scoreboard) analysis_export;
  
  //constructor
  function new(string name= "mux_scoreboard",uvm_component parent);
    super.new(name,parent);
    `uvm_info("mux_scoreboard", "-constructor", UVM_LOW)
  endfunction:new
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    analysis_export = new("analysis_export", this);
  endfunction : build_phase
  
  // write task - recives the pkt from monitor and pushes into queue
  //write function
  function void write(mux_seq_item pkt);
    int expected = pkt.in[pkt.s];
    `uvm_info("SB", $sformatf("Scoreboard received: s=%0d expected=%0h out=%0h", pkt.s, expected, pkt.out), UVM_LOW)
    if(pkt.rst) begin
      if(pkt.out==0)begin
        $display("Test is passed at time %0t: in[%0d] = %0h, out = %0h, rst =%d", $time, pkt.s, expected, pkt.out,pkt.rst);
      end
    end
    else begin
      if (pkt.out !== expected) begin
      $error("Mismatch at time %0t: in[%0d] = %0h, but out = %0h", $time, pkt.s, expected, pkt.out);
      end
    end
  endfunction

endclass
