virtual class test_base_t;
int op_sequence[];
int index;

extern function new();

pure virtual function void start();

extern function void setup_sequence(input int op[]);
extern virtual function simple_item_t next_item();
extern virtual function simple_item_t make_item(input int op);
endclass

function test_base_t::new();
endfunction

function void test_base_t::setup_sequence(input int op[]);
    op_sequence = op;
    index = 0;
endfunction

function simple_item_t test_base_t::next_item();
    if(index < op_sequence.size) return make_item(op_sequence[index++]);
                                 return null;
endfunction

function simple_item_t test_base_t::make_item(input int op);
    make_item = new;
    case(op)
    RESET: make_item.reset = 1;
    LOAD: begin
        make_item.load = 1;
        make_item.d = $urandom;
    end
    UP: make_item.up_down = 1;
    DOWN: make_item.up_down = 0;
    endcase
endfunction

