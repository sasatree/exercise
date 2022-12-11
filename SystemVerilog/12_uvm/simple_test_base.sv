class simple_test_base_t extends uvm_test;
simple_env_t env0;

`uvm_component_utils(simple_test_base_t)

function new(string name, uvm_component parent = null);
    super.new(name, parent);
endfunction

extern function void build_phase(uvm_phase phase);

endclass

function void simple_test_base_t::build_phase(uvm_phase phase);
    super.build_phase(phase);
    env0 = simple_env_t::type_id::create("env0", this);
endfunction
