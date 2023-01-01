class test_driver;
  virtual interface if1 v1;//初期状態はnull
  int	  my_num;

  function new(virtual interface if1 v_,int num);//class コンストラクタで初期化するのが常套
  v1=v_;
  my_num=num;
endfunction
  

  task  random_walk(int rep);//class のtask/functionは、default automatic
    
    repeat(rep) begin
      $display("my num=%1d: v1.enable=%b %m %d",my_num,v1.enable,$time);
      #($urandom_range(7,1)*100);//program domain なのでraceの心配無用
      v1.enable=~v1.enable;//program domain なのでraceの心配無用
    end
    
  endtask
  
endclass :test_driver

class  test_driver_top #(parameter int NUM_OF_INSTANCES=3);
  
  test_driver q[NUM_OF_INSTANCES];
  
  function new (virtual interface if1 ifa[NUM_OF_INSTANCES]);
  foreach (ifa[i])       q[i]=new (ifa[i],i);
endfunction
  
  task seq_test(int rep);//シーケンシャル
    foreach (q[i]) begin
      q[i].random_walk(rep);
    end
  endtask
  
        task parallel_test(int rep);
          foreach (q[i]) begin
            fork    //Go パラレル
              automatic int k=i;//Thrの同時起動(fork)定石パターン
              begin
                $display("Go parallel k=%d",k);
                q[k].random_walk(rep);
              end
            join_none
          end
          wait fork;//全Thr終了待ち
          $display("All threads finished!");
        endtask 
  
  task seq_par_test;
    seq_test(3);
    $display("\n");
    parallel_test(3);
  endtask
  
endclass :test_driver_top

interface if1(input clk);//インターフェース
  int counter=0;
  bit enable=0;
  
endinterface:if1


module counter (interface c1);//カウンタモジュール
  always @(posedge c1.clk) begin
    if (c1.enable) c1.counter<=c1.counter+1;
  end
  
endmodule:counter       


module counter_array #(parameter int NUM_OF_INSTANCES=3)  (interface IF_ARRAY[NUM_OF_INSTANCES]) ;
  
  for (genvar g=0;g < NUM_OF_INSTANCES;g++) counter c(IF_ARRAY[g]) ;//カウンタモジュールとインタフェースの接続
  
endmodule :counter_array

program automatic test #(parameter int NUM_OF_INSTANCES=3) (interface IF_ARRAY[NUM_OF_INSTANCES]) ;
  
  
  test_driver_top #(NUM_OF_INSTANCES)  tdp;//クラスハンドル宣言
  
  initial begin
    
    tdp=new(IF_ARRAY);//インタフェースをテストベンチに渡す
    tdp.seq_par_test();//テスト起動 
    //implicit $finish call
  end                     
endprogram :test
  
module top;
  parameter int NUM_OF_INSTANCES=3;
  
  //clock
  bit clk=0;//CLOCK元
  always #10 clk=~clk;
  
  //インターフェース
  if1 IF_ARRAY[NUM_OF_INSTANCES] (clk);//インターフェースのインスタンス化
  
  //カウンタ
  counter_array #(NUM_OF_INSTANCES) counter_objects(IF_ARRAY);//カウンタのインスタンス化

  //テストベンチ
  test #(NUM_OF_INSTANCES) test_drivers(IF_ARRAY);
endmodule :top;
