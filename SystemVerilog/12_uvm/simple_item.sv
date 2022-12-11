class simple_item_t extends uvm_sequence_item;
rand logic [NBITS-1:0] d;
logic [NBITS-1:0] q, qn;
rand logic             reset, load, up_down;

`uvm_object_utils_begin(simple_item_t)
    `uvm_field_int(reset, UVM_DEFAULT)
    `uvm_field_int(load, UVM_DEFAULT)
    `uvm_field_int(up_down, UVM_DEFAULT)
    `uvm_field_int(d, UVM_DEFAULT)
    `uvm_field_int(q, UVM_DEFAULT)
    `uvm_field_int(qn, UVM_DEFAULT)
`uvm_object_utils_end

function new(string name="simple_item_t");
    super.new(name);
endfunction

endclass
