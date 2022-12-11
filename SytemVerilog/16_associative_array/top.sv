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


  sample_t sample[string][int];


  int size;
  string key;

  initial begin
    size = $urandom_range(5,10);

    sample["A"][1] = new("A1");
    sample["A"][2] = new("A2");
    

    foreach(sample[i,j])begin
      $write(" %s", sample[i][j].get_name);
      $display;
    end
    

  end

endmodule
