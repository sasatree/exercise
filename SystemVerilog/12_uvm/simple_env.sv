class simple_env_t extends uvm_env;

simple_agent_t agent0;

`uvm_component_utils(simple_env_t)

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent0 = simple_agent_t::type_id::create("agent0", this);
endfunction

endclass
