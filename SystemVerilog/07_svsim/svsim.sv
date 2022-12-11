`timescale 1ns / 1ps

module dut(input [7:0] a,b, output co, [7:0] sum);
    assign {co,sum} = a+b;
endmodule

module top;

semaphore mutex;
logic [7:0] a,b, sum;
logic co;
bit clk;

clocking cb@(posedge clk); endclocking
dut DUT(.*);

initial begin
    mutex = new(1);
    fork
        drive_low();
        driver_high();
        collector();
    join_none
    #1000 $finish();
end

initial forever #10 clk = ~clk;


task        drive_low();
logic [7:0] tmp_a, tmp_b;

    forever begin
        repeat ($urandom%10) @cb;
        tmp_a = $urandom&8'h0f;
        tmp_b = $urandom&8'h0f;
        drive_dut(tmp_a, tmp_b);
    end
endtask

task        driver_high();
logic [7:0] tmp_a, tmp_b;
    forever begin
        repeat( $urandom%10) @cb;
        assert( std::randomize(tmp_a, tmp_b)
            with{tmp_a >= 128 && (tmp_b >= 128);});
        drive_dut(tmp_a, tmp_b);
    end
endtask

task automatic drive_dut(input logic [7:0] a1, a2);
    mutex.get(1);
    @cb;
    a = a1;
    b = a2;
    mutex.put(1);
endtask

task collector();
    $display("        a    b {co,sum}" );
    forever @(a,b)
        #0 $display("@%3t:   %3d    %3d       %3d", $time, a,b,{co,sum});
endtask

endmodule
