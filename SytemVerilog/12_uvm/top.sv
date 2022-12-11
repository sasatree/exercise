`include "uvm_macros.svh"
`include "pkg.sv"
`include "simple_if.sv"
`include "up_down_counter.sv"

module top;
    import uvm_pkg::*;
    import pkg::*;
    import pkg_definitions::*;

    bit clk;
    simple_if SIF(.*);

    up_down_counter #(.NBITS(NBITS))
        DUT(.clk, 
            .reset(SIF.reset),
            .load(SIF.load),
            .up_down(SIF.up_down),
            .d(SIF.d),
            .q(SIF.q),
            .qn(SIF.qn) );

    initial begin
        uvm_config_db #(virtual simple_if)::set(null, "*env0*", "vif", SIF)  ;
        run_test();
    end

    initial forever #10 clk = ~clk;

endmodule
