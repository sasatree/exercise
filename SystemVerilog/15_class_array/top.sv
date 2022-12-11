class sample_t;

local string name;

function new(string name);
    this.name = name;
endfunction

function string get_name();
    return name;
endfunction

endclass

module top;
sample_t sample[];

int size;

initial begin
    size = $urandom_range(5,10);
    sample = new[size];

    foreach(sample[i])
        sample[i] = new($sformatf("sample_%02d", i));

    $write("sample[%0d..%0d]:", $left(sample), $right(sample));

    foreach(sample[i])
        $write(" %s\n", sample[i].get_name());
end

endmodule
