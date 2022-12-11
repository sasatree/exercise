class simple_sequence2_t extends simple_sequence_base_t;

`uvm_object_utils(simple_sequence2_t)

function new(string name="simple_sequence2_t");
    super.new(name);
endfunction

extern virtual task body();

endclass

task simple_sequence2_t::body();
    `uvm_do(seq_load)
    `uvm_do(seq_up)
    `uvm_do(seq_down)
    `uvm_do(seq_reset)
    `uvm_do(seq_up)
    `uvm_do(seq_up)
    `uvm_do(seq_down)
endtask
