class simple_test2_t extends simple_test_base_t;

`uvm_component_utils(simple_test2_t)

function new(string name="simple_test2_t", uvm_component parent = null);
    super.new(name, parent);
endfunction

extern function void build_phase(uvm_phase phase);

endclass

function void simple_test2_t::build_phase(uvm_phase phase);
    uvm_config_db#(uvm_object_wrapper)::set(this,
    "env0.agent0.sequencer.run_phase",
    "default_sequence", simple_sequence2_t::type_id::get());

    super.build_phase(phase);
endfunction
