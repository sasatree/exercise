class simple_agent_t extends uvm_agent;
simple_driver_t driver;
simple_sequencer_t sequencer;
simple_collector_t collector;
simple_monitor_t monitor;

`uvm_component_utils_begin(simple_agent_t)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
`uvm_component_utils_end

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass

function void simple_agent_t::build_phase(uvm_phase phase);
    super.build_phase(phase);
    collector = simple_collector_t::type_id::create("collector", this);
    monitor = simple_monitor_t::type_id::create("monitor", this);

    if( is_active == UVM_ACTIVE )begin
        sequencer = simple_sequencer_t::type_id::create("sequencer", this);
        driver = simple_driver_t::type_id::create("driver", this);
    end
endfunction

function void simple_agent_t::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    collector.analysis_port.connect(monitor.analysis_export);
    
    if(is_active == UVM_ACTIVE ) begin
        driver.seq_item_port.connect(sequencer.seq_item_export);
    end
endfunction
