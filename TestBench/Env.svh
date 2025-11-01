/////////////////*****************ENVIRONMENT FILE*****************/////////////////
//class declaration
class mux_env extends uvm_env;
  
  //factory registration
  `uvm_component_utils(mux_env)
  //handle creation
  mux_agent agent;
  mux_scoreboard scb;  
  //constructor
  function new(string name = "mux_env",uvm_component parent);
    super.new(name,parent);
    `uvm_info("mux_env", "constructor", UVM_LOW)
  endfunction:new
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb = mux_scoreboard::type_id::create("scb", this);
    agent = mux_agent::type_id::create("agent", this);
  endfunction : build_phase

  // connect phase
   function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
     `uvm_info("env Class", "connect phase", UVM_LOW);
     agent.mon.analysis_port.connect(scb.analysis_export);
   endfunction:connect_phase
endclass
