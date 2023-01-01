module top;

  bit clk = 0;
  always #10 clk = ~clk;

interface if1(input clk);
  int counter = 0;
  bit enable = 0;

  always @(posedge clk)
    if(enable) counter <= counter + 1;
endinterface
  
  if1 IF1(clk);
  if2 IF2(clk);

program;
  virtual interface if1 v1, v2;

  task aoutomatic random_walk(virtual interdace if1 V, int rep);

    repeat(rep) begin
      #($urandom_range(7,1)*100);
      V.enable =~ V.enable;
    end
  endtask 

  initial begin
    v1 = IF1;
    v2 = IF2;

    random_walk(v1,10);
    random_walk(v2,10);

    fork
      random_walk(v1,20);
      random_walk(v2,10);
    join
  end
endprogram

endmodule

