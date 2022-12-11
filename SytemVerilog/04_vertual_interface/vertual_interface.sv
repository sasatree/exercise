class sample_t;
    string name;
    virtual simple_if vif;

    function new(string name);
        this.name = name;
    endfunction

    function void set_vif(virtual simple_if sif);
        vif =sif;
    endfunction
endclass

interface simple_if(input bit clk);
logic a,b;

    clocking cb@(posedge clk); endclocking
    modport DUT(input clk, inout a,b);
    initial begin
        a =0;
        b =0;
    end
endinterface

module dut(simple_if.DUT mp);
    always@(posedge mp.clk) begin
        mp.b <= mp.a;
        mp.a <= mp.b;
    end
endmodule

class data_item_t;
    rand bit [15:0] aux;
    bit             a, b;

    function void post_randomize();
        a = ^aux;
        b = aux[0];
    endfunction
endclass

class test_t;
    data_item_t item;
    virtual simple_if vif;

    function new;
    endfunction

    function void set_vif(virtual simple_if sif);
        vif = sif;
    endfunction

    extern task run();
    extern task driver();
    extern task drive_dut();
    extern task collector();
    extern function void check();
endclass

task test_t::run();
    item = new;
    fork
        driver();
        collector();
    join
endtask

task test_t::driver();
    forever begin
        @(negedge vif.clk);
        assert( item.randomize());
        drive_dut();
    end
endtask

task test_t::drive_dut();
    vif.a <= item.a;
    vif.b <= item.b;
endtask

task test_t::collector();
    forever begin
        @vif.cb;
        check();
    end
endtask

function void test_t::check();
    string result;
    result = (item.a == vif.b) && (item.b == vif.a) ? "PASS" : "FAIL";
    $display("@%3t: _a=%b _b=%b a=%b b=%b %s",
            $time, item.a, item.b ,vif.a ,vif.b, result);
endfunction

module top;
    bit clk;
    test_t test;

    simple_if SIF(.clk(clk));
    dut   DUT(SIF);

    initial begin
        test = new;
        test.set_vif(SIF);
        test.run();
    end
    initial forever #10 clk = ~clk;
    initial #150 $finish;
endmodule
