
#include "gf.cpp"

int main()
{
  //Simulation time Measurement
  std::chrono::system_clock::time_point start,end;
  start = std::chrono::system_clock::now();

  // 関数の引数

  // n, k, t
  // n = 符号長
  // k = 情報長
  // t = 訂正ビット数

  int          M ; M = 4 ; // 2^M 冪乗の設定
  unsigned int t ; t = 2 ; // 訂正ビット数
  //  int      k ; k = 3 ; // 情報長 = (2^M-1) - parity_size(生成多項式の最高次数)

  gf           gf4 {M,t}; // インスタンスと初期化。初期化時にfieldを生成する。

  gf4.show_field();

  // 最小多項式生成
  gf4.make_min_polynominal();

  //  gf4.show_conjugate_root();
  gf4.show_mini_poly();
  
  // 生成多項式生成
  gf4.make_generate_poly();
  gf4.show_generate_poly();

  // send dat 生成
  gf4.make_send_dat   ();
  //gf4.show_send_dat   ();
  //gf4.show_send_parity();





  //Simulation time Measurement
  end = std::chrono::system_clock::now();
  auto elapsed = std::chrono::duration_cast< std::chrono::microseconds >(end - start).count();
  std::cout << elapsed <<"ms"<< std::endl;

}
