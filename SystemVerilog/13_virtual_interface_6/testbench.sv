
class testbench_t;
run_param_t run_param;

extern function new();
extern task run_test(virtual simple_if sif);
extern function test_base_t get_testcase();
extern task run(run_param_t run_param);

endclass

function testbench_t::new();
    run_param = new;
endfunction

task testbench_t::run_test(virtual simple_if sif);
    run_param.testcase = get_testcase();
    run_param.set_if(sif);
    run(run_param);
    $finish;
endtask

function test_base_t testbench_t::get_testcase();
int number;
    if( $value$plusargs("TESTCASE=%d", number)) begin
        if(number == 1) return test1_t::new();
        if(number == 2) return test2_t::new();

            //return $fatal(0, "TESTCASE is uncorrect");
            $display("TESTCASE is uncorrect");
    end
    //return $fatal(0, "TESTCAE is not provided");
    $display("TESTCAE is not provided");

endfunction

task testbench_t::run(run_param_t run_param);
driver_t driver;
collector_t collector;

    driver = new;
    collector = new;
    driver.setup_if(run_param.vif);
    collector.setup_if(run_param.vif);
    run_param.testcase.start();

    fork
        driver.run(run_param.testcase);
        collector.run();
    join_any
endtask
