//class declaration
class mux_sequence extends uvm_sequence #(mux_seq_item);
  
  //factory registration
  `uvm_object_utils(mux_sequence)
  
  //handle creation
  mux_seq_item#(32, 16, 4) seq_item;
  
  //constructor-build phase
  function new(string name ="mux_sequence");
    super.new(name);
    `uvm_info("mux_sequence", "constructor", UVM_LOW)
    $display("Sequence");
  endfunction

  //task body
  task body();
    $display("started");
    seq_item = mux_seq_item#(32, 16, 4)::type_id::create("seq_item",null);
    //forever #5 seq_item.clk=~seq_item.clk;//don't use it here sequence doesn't generate waveforms.
    #40 seq_item.rst = 1'b0;
    $display("--------------reset---------------");
    repeat(50) begin
      //seq_item=dff_seq_item::type_id::create("seq_item",null);
      start_item(seq_item);
      //wait_for_grant();
      foreach(seq_item.in[i])begin
        seq_item.in[i]=$urandom_range(32'h0,32'hFFFFFFFF);
        $display("in[%0d]=%h",i,seq_item.in[i]);
      end
      seq_item.s=$urandom_range(4'b0000,4'b1111);
      //$display("sequence");
      //#40 seq_item.rst = 0;
      //wait_for_item_done();
      finish_item(seq_item);
    end
    $display("reset---------------eeeeennnnddd");
  endtask
endclass
