interface simple_if import pkg_definitions::*; (input logic clk);

logic [NBITS-1:0] d, q, qn;
logic             reset, load, up_down;

clocking cb@(posedge clk); endclocking
clocking cbr @(posedge reset); endclocking
initial begin
    reset = 0;   
    load = 0;
    up_down = 1;
end
endinterface


