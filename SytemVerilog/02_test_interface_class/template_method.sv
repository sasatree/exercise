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
} T_cComp_result;

interface if_median;
    TYPE_DUT_A1  mem_a1;
    TYPE_DUT_A2  mem_a2;
    logic        sim_result;
    T_log_result log_result[string][int];
endinterface

module TB_MEDIAN(input clk, if_median if_median);
    function cComp_a1;
        input TYPE_DUT_A1 dut_data;
        output int count_num, err_num;
        int result;
        count_num = 1;
        return result;
    endfunction
    function cComp_a2;
        input TYPE_DUT_A1 dut_data;
        output int count_num, err_num;
        int result;
        count_num = 1;
        return result;
    endfunction

    function T_cComp_result select_cComp(input string func_name);
        T_cComp_result cComp_result;
        if(func_name == "A-1") cComp_result.result = cComp_a1(if_median.mem_a1, cComp_result.count_num, cComp_result.err_num); return cComp_result;
        if(func_name == "A-2") cComp_result.result = cComp_a2(if_median.mem_a2, cComp_result.count_num, cComp_result.err_num); return cComp_result;
    endfunction

    interface class virtual_base_class;
        pure virtual function T_log_result get_result(input string func_name);
    endclass

    class a1_check implements virtual_base_class;

        local int      result, count_num, err_num;
        local T_cComp_result cComp;
        local T_log_result   log_result;

        virtual function T_log_result get_result(input string func_name);
            cComp = select_cComp(func_name);
            // cComp.result
            // cComp.count_num
            // cComp.err_num

            // count

            // disp

            log_result.check_num    = cComp.count_num;
            log_result.disp_summary = "";

            return log_result;
        endfunction
    endclass

    a1_check _a1_check  = new ;
    a1_check _a2_check  = new ;

    always @ (posedge clk)begin

        repeat (10) @(posedge clk);

        if(1) if_median.log_result["A"][1] = _a1_check.get_result("A-1");
        if(1) if_median.log_result["A"][2] = _a2_check.get_result("A-2");

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
