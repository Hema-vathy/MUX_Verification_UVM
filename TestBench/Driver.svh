//////////////////////**********************DRIVER FILE**********************//////////////////////
//class declaration
class mux_driver extends uvm_driver #(mux_seq_item);
  
  //factory registration
  `uvm_component_utils(mux_driver)
  
  //handle for interface
  virtual mux_if vif;
  mux_seq_item#(32, 16, 4) seq_item;;
  
  //constructor
  function new(string name= "mux_driver",uvm_component parent);
    super.new(name,parent);
    `uvm_info("mux_driver", "constructor", UVM_LOW)
  endfunction
  
 
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual mux_if)::get(this," ", "vif", vif))
      `uvm_fatal("NO_VIF","virtual interface must be set");
  endfunction: build_phase
  
  //task body
  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(seq_item);
      //$display("driver");
      drive();
      seq_item_port.item_done();
    end
  endtask 
  //drive task
  task drive();
    @(posedge vif.clk or negedge vif.clk)
    vif.rst = seq_item.rst;
    vif.in = seq_item.in;
    vif.s = seq_item.s;
  endtask
endclass
