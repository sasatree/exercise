`timescale 1ns / 1ps

virtual class if_median_check;
    pure virtual function base_dut_update;
    pure virtual function base_get_compare_enable;
    pure virtual function base_get_reslt;
    pure virtual function void base_disp_err_count(string , int);
endclass

class base_check extends if_median_check;
    function base_dut_update;
    endfunction

    function base_get_compare_enable;
    endfunction

    function base_get_reslt;
    endfunction

    function void base_disp_err_count(input string check_name, input int err_count); // 共通ロジック
        $display("%t ===== Call base_disp_err %s err_count %d", $time, check_name, err_count);
    endfunction
endclass

class a1_check;
    local static string check_name;
    local static int result;
    local static int err_count;
    local static logic [31:0] a1_dut_data[4];
    base_check check;

    function new;
        check_name = "a1_check";
        check = new;
        result = -1;
        err_count = 0;
        foreach(a1_dut_data[i]) a1_dut_data[i] = 0;
    endfunction

    function dut_update;
        for(int iii =0; iii<4; iii++)begin
            a1_dut_data[iii] = $random();
        end 
    endfunction

    function get_compare_enable;
        if(top.counter == 'd10)
            return 1;
    endfunction

    function get_reslt;
        if(get_compare_enable)
            $display("Call a1 get_result %d", a1_dut_data[0]);
    endfunction

    function void disp_err_count;
        if(top.counter == 'd15)
            check.base_disp_err_count(check_name, err_count);
    endfunction
endclass

class a2_check ;
    local static string check_name;
    local static int result;
    local static int err_count;
    base_check check;
    function new;
        check_name = "a2_check";
        check     = new;
        result    = -1;
        err_count = 0;
    endfunction

    function dut_update;
        check.base_dut_update;
    endfunction

    function get_compare_enable;
    endfunction

    function get_reslt;
    endfunction

    function void disp_err_count;
        if(top.counter == 15)
            check.base_disp_err_count(check_name, err_count);
    endfunction
endclass

module dut(
    input reset_x, clk, enable,
    output reg [15:0] counter
    );
    parameter P_DLY = 2;
    always@(posedge clk or negedge reset_x)
        if(~reset_x)
            counter <= #P_DLY 0;
        else if(enable)begin
            counter <= #P_DLY counter + 1;
        end
endmodule

module top;
    reg clk, reset_x, enable;

    initial clk = 0    ; always #10 clk <= ~clk;
    initial begin 
        reset_x = 1;
        #10 reset_x = 0;
        #10 reset_x = 1;
    end
    initial begin
        enable  = 0;
        #100 enable = 1;
    end
    wire [15:0] counter;
    dut dut(.reset_x(reset_x),.clk(clk),.enable(enable),.counter(counter));

    a1_check a1_check = new;
    a2_check a2_check = new;

    always @ (posedge clk)begin
        a1_check.dut_update;
        a1_check.get_compare_enable;
        a1_check.get_reslt;
        a1_check.disp_err_count;

        a2_check.dut_update;
        a2_check.get_compare_enable;
        a2_check.get_reslt;
        a2_check.disp_err_count;

        $display("%t=====%d", $time, counter);
        simulation_end(counter);


    end
endmodule

function void simulation_end(input [15:0] counter);
    if(counter == 'd15) begin
        $display("==========================");
        $display("===== Simulation End =====");
        $display("==========================");
        $finish;
    end
endfunction
