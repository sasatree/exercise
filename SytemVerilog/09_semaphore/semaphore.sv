`timescale 1ns / 1ps



module top;


semaphore proc2_ready;
bit a;


initial begin
    proc2_ready = new ;
    fork
        proc1;
        proc2;
    join
end

task proc1;
    $display("@%0t proc1 is ready", $time);
    proc2_ready.get(1);
    $display("@%0t proc1 resumed", $time);
    a = 1;
    $display("@%0t proc1 is done", $time);
endtask

task proc2;
    $display("@%0t proc2 is ready", $time);
    proc2_ready.put(1);
    $display("@%0t proc2 is just before @a", $time);
    @a;
    $display("@%0t proc2 got 'a'", $time);
endtask

endmodule




