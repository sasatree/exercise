module top;
int q[$]  = {-1, -2, -3, -4, -5};
byte da[] =  {10, 20, 30, 40, 50};
shortint fa[3] = {100, 200, 300 };

initial begin;
    print("q",   q);
    print("da", da);
    print("fa", fa);
end

function void print(input string msg, input int a[]);
    $write("%s:", msg);
    foreach(a[i])
        $write(" %0d", a[i]);
    $display;
endfunction

endmodule
