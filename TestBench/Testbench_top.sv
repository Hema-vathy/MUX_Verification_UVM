//////////////***************TOP FILE***************//////////////
`include "uvm_macros.svh" // contains all uvm macros
import uvm_pkg::*;
`include "mux_interface.svh"
`include "mux_seq_item.svh"
`include "mux_seq.svh"
`include "mux_sequencer.svh"
`include "mux_driver.svh"
`include "mux_monitor.svh"
`include "mux_agent.svh"
`include "mux_scoreboard.svh"
`include "mux_env.svh"
`include "mux_test.svh"
module mux_tb_top;
  //creating handle for interface
  mux_if vif();
  //DUT Instance
  mux dut(.clk(vif.clk),
          .rst(vif.rst),
          .in(vif.in),
          .s(vif.s),
          .out(vif.out));
  
  
  //Initialization block
  initial begin
    vif.clk=0;
    vif.rst = 1; 
    foreach(vif.in[i])begin
      vif.in[i]=32'hA;
    end
    vif.s=4'b0000;
  end
  
  task clk_gen();
    forever #5 vif.clk=~vif.clk;
  endtask
  // reset generation block
  task rst_gen();
    #40 vif.rst=1'b0;
  endtask
   

  initial begin
  uvm_config_db#(virtual mux_if)::set(null, "*", "vif", vif);
end

  
  initial begin
    $monitor($time,"clk=%b,rst=%b,in[s]=%h,out=%h,s=%d",vif.clk,vif.rst,vif.in[vif.s],vif.out,vif.s);
  end
  
  initial begin
    fork
      clk_gen();
      rst_gen();
    join

  end
 
  
  //Calling run test
  initial begin
    run_test("mux_test");
    `uvm_info("Run phase","run_test initiated",UVM_LOW)
  end
  //dump file
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1,mux_tb_top);
  end
endmodule
    
