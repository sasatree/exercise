class simple_sequence_reset_t extends uvm_sequence #(simple_item_t);

`uvm_object_utils(simple_sequence_reset_t)

function new(string name="simple_sequence_reset_t");
    super.new(name);
endfunction

extern virtual task body();

endclass

task simple_sequence_reset_t::body();
    // RESET
    `uvm_do_with(req, {(req.reset==1) && (req.load==0) && (req.up_down==0) && (req.d==0);} )
endtask

