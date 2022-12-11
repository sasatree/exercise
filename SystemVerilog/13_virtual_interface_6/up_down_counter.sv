module up_down_counter #(NBITS=4)
    (input clk, reset, load, up_down, logic [NBITS-1:0] d,
    output logic [NBITS-1:0] q, qn);

logic [NBITS-1:0] counter;
assign q = counter;
assign qn = ~counter;

always @(posedge clk, posedge reset )
    if(reset)
        counter <= 0;
    else if(load)
        counter <= d;
    else if(up_down)
        counter <= counter + 1;
    else
        counter <= counter - 1;

endmodule

