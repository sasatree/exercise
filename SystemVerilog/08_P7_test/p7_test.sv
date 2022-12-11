`timescale 1ns / 1ps

module dut(
clk,reset_n,
latch_en,
update_data,
check_timing
);
input clk,reset_n ;
output reg latch_en ;
output reg [7:0] update_data ;
output reg check_timing ;

always@( posedge clk or negedge reset_n )begin
    if(~reset_n)begin
        latch_en     <= #4 0 ;
    end
    else 
        latch_en     <= #4 ~latch_en ;
end


reg [7:0] update_data_pre ;

always@( posedge clk or negedge reset_n )begin
    if(~reset_n)begin
        update_data_pre <= #4 0 ;
        update_data     <= #4 0 ;
    end
    else if(latch_en) begin
        update_data <= #4 $random();
    end
end

always@( posedge clk or negedge reset_n )begin
    if(~reset_n)begin
        check_timing <= #4 0 ;
    end
    else
        check_timing <= #4 ~check_timing ;
end
endmodule


module top;

reg clk, reset_n;

always begin
        clk = 0;
    #10 clk = 1;
    #10;
end

initial begin
    #0;
    reset_n = 1 ;
    #10;
    reset_n = 0 ;
    #10;
    reset_n = 1 ;
    #140;
    $finish;
end

wire latch_en ;
wire [7:0] update_data ;
wire check_timing ;
dut dut(.clk        (clk         ),
    .reset_n        (reset_n     ),
    .latch_en       (latch_en    ),
    .update_data    (update_data ),
    .check_timing   (check_timing)
);

reg [7:0] latch_data ;


//always @ (posedge clk)begin
//  $display("=====latch_en=%d update_data=%h check_timing=%d", latch_en, update_data, check_timing);
//  $display("");
//end

always begin
    @(negedge latch_en )begin

        $display("=====latch_en=%d update_data=%h latch_data=%h", latch_en, update_data, latch_data );
        latch_data <= update_data;
        $display("=====latch_en=%d update_data=%h latch_data=%h", latch_en, update_data, latch_data );
        $display("");
    end
end

always begin
    @(negedge check_timing )begin

        $display("=====check_timing=%d latch_data=%h", check_timing, latch_data );
        latch_data = 0;
        $display("=====check_timing=%d latch_data=%h", check_timing, latch_data );
        $display("");
    end
end

always begin
    @(negedge clk)begin
        $display("=====latch_data=%h", latch_data);
    end
end

endmodule
