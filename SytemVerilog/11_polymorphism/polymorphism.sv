`timescale 1ns / 1ps

typedef logic [31:0][0:3] TYPE_DUT_A1;
typedef logic [31:0]      TYPE_DUT_A2;

typedef struct{
    int    check_num;
    string disp_summary;
} T_log_result;

typedef struct{
    int result;
    int count_num;
    int err_num;
} T_compare_result;

interface if_median;
    TYPE_DUT_A1  mem_a1;
    TYPE_DUT_A2  mem_a2;
    logic        sim_result;
    T_log_result log_result[string][int];
endinterface

module TB_MEDIAN(input clk, if_median if_median);
    function compare_a1;
        input TYPE_DUT_A1 dut_data;
        output int count_num, err_num;
        int result;
        count_num = 1;
        return result;
    endfunction
    function compare_a2;
        input TYPE_DUT_A2 dut_data;
        output int count_num, err_num;
        int result;
        count_num = 1;
        return result;
    endfunction

    function T_compare_result select_compare(input string func_name);
        T_compare_result compare_result;
        if(func_name == "A-1") begin compare_result.result = compare_a1(if_median.mem_a1, compare_result.count_num, compare_result.err_num); return compare_result; end
        if(func_name == "A-2") begin compare_result.result = compare_a2(if_median.mem_a2, compare_result.count_num, compare_result.err_num); return compare_result; end
    endfunction

    class value_object;
        T_compare_result ddd;

        function new( T_compare_result ddd);
            this.ddd = ddd;
        endfunction

        function void show();
            $display("===== result=%d", ddd.result);
        endfunction
    endclass

    interface class virtual_base_class;
        pure virtual function T_log_result get_result(input string func_name);
    endclass

    class median_check implements virtual_base_class;

        local int            result, count_num, err_num;
        local T_compare_result compare;
        local T_log_result   log_result;

        value_object _value_object;

        virtual function T_log_result get_result(input string func_name);
            compare = select_compare(func_name);
            _value_object = new(select_compare(func_name));
            _value_object.show();

            log_result.check_num    = compare.count_num;
            log_result.disp_summary = "";

            return log_result;
        endfunction
    endclass

value_object    _value_object;


    median_check a1_check  = new ;
    median_check a2_check  = new ;


    always @ (posedge clk)begin

        repeat (10) @(posedge clk);

        if(1) if_median.log_result["A"][1] = a1_check.get_result("A-1");
        if(1) if_median.log_result["A"][2] = a2_check.get_result("A-2");

        repeat (10) @(posedge clk);

        $finish;
    end

endmodule

module top;
    reg clk;
    initial clk = 0    ; always #10 clk <= ~clk;

if_median IFM();

TB_MEDIAN TB_MEDIAN(clk, IFM);

endmodule
