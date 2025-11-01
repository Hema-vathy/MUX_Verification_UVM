/////////////////////****************AGENT FILE****************/////////////////////
//class declaration
class mux_agent extends uvm_agent;
  
  //factory registration
  `uvm_component_utils(mux_agent)
  
  //handle creation
  mux_driver drv;
  mux_monitor mon;
  mux_sequencer seqr;  
  
  //constructor
  function new(string name="mux_agent",uvm_component parent);
    super.new(name,parent);
    `uvm_info("mux_agent", "constructor", UVM_LOW)
  endfunction:new
  
  // active agent or passive agent
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (get_is_active() == UVM_ACTIVE) begin 
      drv = mux_driver::type_id::create("mux_driver", this);
      seqr = mux_sequencer::type_id::create("mux_sequencer", this);
    end
    mon = mux_monitor::type_id::create("mux_monitor", this);
  endfunction : build_phase
  
  //connect phase
   function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (get_is_active()) begin
     `uvm_info("agent Class", "connect phase", UVM_LOW)
    drv.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction:connect_phase
endclass
