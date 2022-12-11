class simple_sequencer_t extends uvm_sequencer #(simple_item_t);
`uvm_component_utils(simple_sequencer_t)

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

endclass
