`include "pkg.sv"
`include "simple_if.sv"
`include "up_down_counter.sv"

module top;

import pkg::*;
import pkg_definitions::*;
bit clk;
testbench_t testbench;

simple_if SIF(.*);

up_down_counter #(.NBITS(NBITS)) DUT(   .clk, 
                                        .reset  (SIF.reset  ), 
                                        .load   (SIF.load   ),
                                        .up_down(SIF.up_down),
                                        .d      (SIF.d      ),
                                        .q      (SIF.q      ),
                                        .qn     (SIF.qn     )
                                        );

initial begin
    testbench = new;
    testbench.run_test(SIF);
end

initial forever #10 clk = ~clk;

endmodule // tb_top
