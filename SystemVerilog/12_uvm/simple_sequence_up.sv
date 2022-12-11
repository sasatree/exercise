class simple_sequence_up_t extends uvm_sequence #(simple_item_t);

`uvm_object_utils(simple_sequence_up_t)

function new(string name="simple_sequence_up_t");
    super.new(name);
endfunction

extern virtual task body();

endclass

task simple_sequence_up_t::body();
    // UP
    `uvm_do_with(req, {req.reset==0 && req.load==0 && req.up_down==1 && req.d==0;})
endtask
