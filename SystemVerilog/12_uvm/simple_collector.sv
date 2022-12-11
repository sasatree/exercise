class simple_collector_t extends uvm_component;

virtual simple_if vif;
simple_item_t item;
uvm_analysis_port #(simple_item_t) analysis_port;

`uvm_component_utils(simple_collector_t)

function new(string name, uvm_component parent);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
endfunction

extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_response();
extern task collect_reset();
extern function void send_item();

endclass

function void simple_collector_t::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if( !uvm_config_db #(virtual simple_if)::get(this, get_full_name(), "vif",vif) )
        `uvm_error("NO-VIF", {"VIF error for ", get_full_name(), ".vif"})
endfunction

task simple_collector_t::run_phase(uvm_phase phase);
    item = simple_item_t::type_id::create("dut_response");
    fork
        collect_response();
        collect_reset();
    join
endtask

task simple_collector_t::collect_response();
    forever begin
        @vif.cb;
        send_item();
    end
endtask

task simple_collector_t::collect_reset();
    forever begin
        @vif.cbr;
        send_item();
    end
endtask

function void simple_collector_t::send_item();
    item.reset = vif.reset;
    item.load = vif.load;
    item.up_down = vif.up_down;
    item.d = vif.d;
    item.q = vif.q;
    item.qn = vif.qn;
    analysis_port.write(item);
endfunction
