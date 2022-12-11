class simple_driver_t extends uvm_driver #(simple_item_t);
virtual simple_if vif;

`uvm_component_utils(simple_driver_t)

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task get_and_drive();
extern task drive_dut(input simple_item_t item);

endclass

function void simple_driver_t::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if( !uvm_config_db #(virtual simple_if)::get(this, get_full_name(), "vif", vif))
        `uvm_error("NO_VIF", {"VIF error for ", get_full_name(),"vif"})
endfunction

task simple_driver_t::run_phase(uvm_phase phase);
    forever begin
        get_and_drive();
    end
endtask

task simple_driver_t::get_and_drive();
    // Get the next data item from sequncer.
    seq_item_port.get_next_item(req);

    // Execute the item.
    drive_dut(req);

    // Tell sequencer that item is done.
    seq_item_port.item_done();
endtask

task simple_driver_t::drive_dut(simple_item_t item);
    if(item.reset) begin
        vif.reset <= 1;
        vif.reset = #1 0;
    end else if(item.load)begin
        vif.load <= 1;
        vif.up_down <= item.up_down;
        vif.d <= item.d;
        @(negedge vif.clk);
    end else begin
        vif.load <= 0;
        vif.up_down <= item.up_down;
        vif.d <= item.d;
        @(negedge vif.clk);
    end
endtask
