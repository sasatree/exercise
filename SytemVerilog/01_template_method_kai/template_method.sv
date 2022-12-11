`timescale 1ns / 1ps

virtual class virtual_base_class;
    pure virtual function dut_update;
    pure virtual function get_compare_enable;
    pure virtual function get_result;

    function void disp_err_count (input print_enable, input string result);
        if(print_enable)
            $display("compare result =%s", result);
    endfunction
endclass

class a1_check extends virtual_base_class;
    static local reg result;

    function dut_update;
    endfunction
    function get_compare_enable;
    endfunction
    function get_result;
    endfunction
endclass

class a2_check extends virtual_base_class;
    static local reg result;

    function dut_update;
    endfunction
    function get_compare_enable;
    endfunction
    function get_result;
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

function void simulation_end(input [15:0] counter);
    if(counter == 'd15) begin
        $display("==========================");
        $display("===== Simulation End =====");
        $display("==========================");
        $finish;
    end
endfunction

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


    reg print_enable = 0;
    always @ (posedge clk)begin

        a1_check.dut_update;
        a1_check.get_compare_enable;
        a1_check.get_result;

        a1_check.disp_err_count(print_enable, "OK" );// bese class のメソッドを使用
        a2_check.disp_err_count(print_enable, "NG" );

        simulation_end(counter);
    end

endmodule

