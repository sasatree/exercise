class driver_t extends component_base_t;

extern task run(test_base_t test);
extern task drive_dut(simple_item_t item);

endclass

task driver_t::run(test_base_t test);
simple_item_t item;

    forever begin
        item = test.next_item();
        if(item == null)
            break;
        drive_dut(item);
    end

endtask


task driver_t::drive_dut(simple_item_t item);

    if(item.reset) begin
        vif.reset <= 1;
        vif.reset = #1 0;
    end
    else if(item.load)begin
        vif.load    <= 1;
        vif.up_down <= item.up_down;
        vif.d       <= item.d;
        @(negedge vif.clk);
    end
    else begin
        vif.load <= 0;
        vif.up_down <= item.up_down;
        vif.d <= item.d;
        @(negedge vif.clk);
    end

endtask
