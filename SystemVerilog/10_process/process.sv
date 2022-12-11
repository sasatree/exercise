`timescale 1ns / 1ps

module dut(
    input clk,
    input d,
    output logic q, qbar
    );

assign qbar = ~q;   // p1

always @(posedge clk) // p2
    q <= d;

endmodule

module test(input clk,q,qbar, output logic d);
    string judgement;


    clocking cb @(posedge clk); endclocking

    initial begin
        for(int i = 0 ; i < 4  ;i++)begin
            d = i;
            @(negedge clk);
            $display("==========");
        end
        $finish;
    end


    initial begin             // p4
        $display("    d q qbar judgement");

    end

    always @cb begin
        judgement = (d == q) && (q == !qbar) ? "pass" : "fail";
        $display("@%2t:  %b %b %b      %s",
                $time, d, q, qbar, judgement);
    end

endmodule


module top;

reg clk ;
logic d,   q,  qbar;

dut DUT(.*);

test TEST(.*);

    initial clk = 0    ; 
    
    always begin 
        #10 clk <= ~clk;
    end

endmodule