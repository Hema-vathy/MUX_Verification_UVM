////////////////////**********************MONITOR FILE***********************//////////////////////////
//class declaration
class mux_monitor extends uvm_monitor;
  //factory registration
  `uvm_component_utils(mux_monitor)
  
  //handle for interface
  virtual mux_if vif;
  uvm_analysis_port #(mux_seq_item) analysis_port;
  mux_seq_item#(32, 16, 4) seq_item;
  
  //constructor
  function new(string name="mux_monitor",uvm_component parent);
    super.new(name,parent);
    `uvm_info("mux_monitor","constructor",UVM_NONE)
  endfunction:new
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    analysis_port = new("analysis_port", this);
    if(!uvm_config_db#(virtual mux_if)::get(this, "", "vif", vif))
      `uvm_fatal("no_inf in driver","virtual interface get failed from config db");
  endfunction : build_phase
    //task body
    task body(uvm_phase phase);
      forever begin @(posedge vif.clk or negedge vif.clk)
        seq_item = mux_seq_item#(32, 16, 4)::type_id::create("seq_item");
        seq_item.rst = vif.rst;
        seq_item.in = vif.in;
        seq_item.s=vif.s;
        seq_item.out= vif.out;
        `uvm_info("MON", $sformatf("Captured at time %0t: s=%0d out=%0h", $time, seq_item.s, seq_item.out), UVM_LOW)
        analysis_port.write(seq_item);
      end
    endtask
    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("MON", "Starting monitor run_phase", UVM_LOW)
      body(phase);
    endtask
endclass
