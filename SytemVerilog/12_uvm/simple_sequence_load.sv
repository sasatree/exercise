class simple_sequence_load_t extends uvm_sequence #(simple_item_t);

`uvm_object_utils(simple_sequence_load_t)

function new(string name="simple_sequence_load_t");
    super.new(name);
endfunction

extern virtual task body();

endclass

task simple_sequence_load_t::body();
    // LOAD
    `uvm_do_with(req, {req.reset==0 && req.load==1 && req.up_down==0;})
endtask
