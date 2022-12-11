class simple_item_t;
logic [NBITS-1:0] d, q, qn;
logic             reset, load, up_down;

function new();
    init();
endfunction

function void init();
    reset =0;
    load = 0;
    up_down =0;
    d = 0;
endfunction

endclass
