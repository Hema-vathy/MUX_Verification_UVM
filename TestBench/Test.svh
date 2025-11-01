///////////////////////***************TEST FILE***************///////////////////////
//class declaration
class mux_test extends uvm_test;
  //factory registration
  `uvm_component_utils(mux_test)
  
  //handle creation
  mux_env env;
  mux_sequence seq;
  
  //constructor
  function new(string name="mux_test",uvm_component parent);
    super.new(name,parent);
    `uvm_info("mux_test", "constructor", UVM_LOW)
  endfunction:new
  
   
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = mux_env::type_id::create("env", this);
    seq = mux_sequence::type_id::create("seq", this);
  endfunction:build_phase
  
  //connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("mux_test", "connect phase", UVM_LOW)
  endfunction:connect_phase

  //task run_phase
  task run_phase(uvm_phase phase);
    `uvm_info("test Class", "run_phase", UVM_LOW)
    phase.raise_objection(this); 
    seq.start(env.agent.seqr); 
    phase.drop_objection(this);
  endtask 
  
endclass

  
