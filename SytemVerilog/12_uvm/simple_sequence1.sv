class simple_sequence1_t extends simple_sequence_base_t;

`uvm_object_utils(simple_sequence1_t)

function new(string name="simple_sequence1_t");
    super.new(name);
endfunction

extern virtual task body();

endclass

task simple_sequence1_t::body();
    `uvm_do(seq_reset)
    `uvm_do(seq_up)
    `uvm_do(seq_up)
    `uvm_do(seq_up)
    `uvm_do(seq_load)
    `uvm_do(seq_up)
    `uvm_do(seq_down)
endtask
