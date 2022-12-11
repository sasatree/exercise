class run_param_t;

virtual simple_if  vif;
test_base_t   testcase;

function void set_if(virtual simple_if sif);
    vif =sif;
endfunction

function void set_testcase(test_base_t testcase);
    this.testcase = testcase;
endfunction

endclass
