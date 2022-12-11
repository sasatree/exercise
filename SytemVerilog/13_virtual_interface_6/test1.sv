
class test1_t extends test_base_t;

int op[] = '{RESET, UP, UP, UP, LOAD, UP, DOWN};

function new();
    super.new();
endfunction

function void start();
    setup_sequence(op);
endfunction

endclass