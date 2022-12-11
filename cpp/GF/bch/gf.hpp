//
//  prim_poly.hpp
//  gf
//
//  Created by ko on 2020/02/22.
//  Copyright © 2020 ko. All rights reserved.
//

//#ifndef prim_poly_h
//#define prim_poly_h

std::bitset<2>  lfsr2 ;
std::bitset<3>  lfsr3 ;
std::bitset<4>  lfsr4 ;
std::bitset<5>  lfsr5 ;
std::bitset<6>  lfsr6 ;
std::bitset<7>  lfsr7 ;
std::bitset<8>  lfsr8 ;
std::bitset<9>  lfsr9 ;
std::bitset<10> lfsr10;
std::bitset<11> lfsr11;
std::bitset<12> lfsr12;
std::bitset<13> lfsr13;
std::bitset<14> lfsr14;
std::bitset<15> lfsr15;
std::bitset<16> lfsr16;
std::bitset<17> lfsr17;
std::bitset<18> lfsr18;
std::bitset<19> lfsr19;
std::bitset<20> lfsr20;
std::bitset<21> lfsr21;
std::vector<unsigned int> field;
std::vector<unsigned int> send_parity;

template<typename T1, typename T2, typename T3, typename T4 > // テンプレートは、型と値を引数にする
void make_poly_field(T1 M, T2 prim_poly, T3 lfsr, T4 &field){

  std::cout << "call make_poly_field"s << "\n"s;

  lfsr.set(0, 1); // [0] に 1 をセットする

  for(int count = 0 ; count < (std::pow(2, M))-1 ; count++){

    field.push_back( lfsr.to_ulong() ); // 配列に追加

    std::cout << prim_poly.to_ulong() << " : " << lfsr << " : " << count << " : " << " : field\n"s;

    if(lfsr[M-1] == 1){ // キャリーシフトする
      lfsr <<= 1;      
      lfsr ^= ( prim_poly.set(M-1,0) );
    }
    else{
      lfsr <<= 1;      // 1bit 左シフト
    }
  }
}

template< typename T1, typename T2, typename T3, typename T4>
void make_parity( T1 M,
		  T2 generate_poly,
		  T3 send_dat,
		  T4 &lfsr ){

  std::cout << "call make_parity"s << "\n"s;

  for(int count = 0 ; count < (std::pow(2, M) -1 -generate_poly.size() ) ; count++){

    printf("%4d", count);

    std::cout << " : " << lfsr << "\n";

    if( send_dat[send_dat.size()-1] ^ lfsr.test(lfsr.size()-1)  ){ // キャリーシフトする
      
      lfsr <<= 1;
      lfsr ^= ( generate_poly.set(M-1,0) ); // 最上位ビットを0にした値とEOR
    }
    else{
      lfsr <<= 1;
    }
    send_dat <<= 1;
  }
}

class gf{
private:
  std::vector<std::vector<unsigned int>> conjugate_root;
  std::vector<std::vector<unsigned int>> pre_poly_make;
  std::vector<unsigned int>              mini_poly;
  std::vector<unsigned int>              poly_1;
  std::vector<unsigned int>              poly_2;
  unsigned int                           poly_make;
  unsigned int                           generate_poly;
  unsigned int                           count_0;
  unsigned int                           count_1;
  unsigned int                           count_11;
  unsigned int                           count_22;

  int                                    M;
  int                                    field_count;
  unsigned int                           t;

public:
  void show_field           ();
  void show_conjugate_root  ();
  void show_mini_poly       ();
  void make_min_polynominal ();
  void make_generate_poly   ();
  void show_generate_poly   ();
  void make_send_dat        ();
  void show_send_dat        ();
  void show_send_parity     ();

  gf(int i=0, unsigned int ii=0) :M{i},t{ii} {         // コンストラクタ
    std::cout << "===== field =====\n"s;
    std::cout << "M : " << M << "\n"s;

    std::bitset<2>  prim_poly1  (std::string("11"));
    std::bitset<3>  prim_poly2  (std::string("111"));
    std::bitset<4>  prim_poly3  (std::string("1011"));
    std::bitset<5>  prim_poly4  (std::string("10011"));
    std::bitset<6>  prim_poly5  (std::string("100101"));
    std::bitset<7>  prim_poly6  (std::string("1000011"));
    std::bitset<8>  prim_poly7  (std::string("10000011"));
    std::bitset<9>  prim_poly8  (std::string("100011101"));
    std::bitset<10> prim_poly9  (std::string("1000010001"));
    std::bitset<11> prim_poly10 (std::string("10000001001"));
    std::bitset<12> prim_poly11 (std::string("100000000101"));
    std::bitset<13> prim_poly12 (std::string("1000001010011"));
    std::bitset<14> prim_poly13 (std::string("10000000011011"));
    std::bitset<15> prim_poly14 (std::string("100010001000011"));
    std::bitset<16> prim_poly15 (std::string("1000000000000011"));
    std::bitset<17> prim_poly16 (std::string("10001000000001011"));
    std::bitset<18> prim_poly17 (std::string("100000000000001001"));
    std::bitset<19> prim_poly18 (std::string("1000000000010000001"));
    std::bitset<20> prim_poly19 (std::string("10000000000000100111"));
    std::bitset<21> prim_poly20 (std::string("100000000000000001001"));
 
    switch(M){
    case 1 :make_poly_field(M, prim_poly1 , lfsr2 , field); break;
    case 2 :make_poly_field(M, prim_poly2 , lfsr3 , field); break;
    case 3 :make_poly_field(M, prim_poly3 , lfsr4 , field); break;
    case 4 :make_poly_field(M, prim_poly4 , lfsr5 , field); break;
    case 5 :make_poly_field(M, prim_poly5 , lfsr6 , field); break;
    case 6 :make_poly_field(M, prim_poly6 , lfsr7 , field); break;
    case 7 :make_poly_field(M, prim_poly7 , lfsr8 , field); break;
    case 8 :make_poly_field(M, prim_poly8 , lfsr9 , field); break;
    case 9 :make_poly_field(M, prim_poly9 , lfsr10, field); break;
    case 10:make_poly_field(M, prim_poly10, lfsr11, field); break;
    case 11:make_poly_field(M, prim_poly11, lfsr12, field); break;
    case 12:make_poly_field(M, prim_poly12, lfsr13, field); break;
    case 13:make_poly_field(M, prim_poly13, lfsr14, field); break;
    case 14:make_poly_field(M, prim_poly14, lfsr15, field); break;
    case 15:make_poly_field(M, prim_poly15, lfsr16, field); break;
    case 16:make_poly_field(M, prim_poly16, lfsr17, field); break;
    case 17:make_poly_field(M, prim_poly17, lfsr18, field); break;
    case 18:make_poly_field(M, prim_poly18, lfsr19, field); break;
    case 19:make_poly_field(M, prim_poly19, lfsr20, field); break;
    case 20:make_poly_field(M, prim_poly20, lfsr21, field); break;
    }
  }// ここまでコンストラクタ


};


//#endif /* prim_poly_h */
