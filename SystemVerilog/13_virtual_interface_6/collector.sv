class collector_t extends component_base_t;

extern task run();
extern task collect_response();
extern task collect_reset();
extern function void print(string msg="");

endclass

task collector_t::run();

string item_form = {"%-", $sformatf("%0d", NBITS), "s"};

$display("item_form=%s", item_form);

    $write("    reset load up_down");
    $write(" %-4s", "d" );
    $write(" %-4s", "q" );
    $write(" %-4s", "qn");
    $write(" command\n");

    fork
        collect_response;
        collect_reset;
    join

endtask

task collector_t::collect_response();

string msg;

    forever begin
        @vif.cb;
        if(vif.load)
            msg = " LOAD";
        else if( vif.up_down )
            msg = " UP";
        else
            msg = " DOWN";
        print(msg);
    end

endtask

task collector_t::collect_reset();
    forever begin
        @vif.cbr;
        print(" RESET");
    end
endtask

function void collector_t::print(string msg="");
    $display("@%3d: %d    %d    %d      %4b %4b %4b%s",
        $time, vif.reset, vif.load, vif.up_down, vif.d, vif.q, vif.qn, msg);
endfunction



