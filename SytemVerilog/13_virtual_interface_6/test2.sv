
class test2_t extends test_base_t;

int op[] = '{LOAD, UP, DOWN, RESET, UP, UP, DOWN};

function new();
    super.new();
endfunction

function void start();
    setup_sequence(op);
endfunction

endclass