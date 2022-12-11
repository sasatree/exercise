//
// gf.cpp
//

#include "gf.hpp"
#include "addGFAlpha.hpp"

void gf::show_field(){ // メンバ関数

  for(field_count = 0 ; field_count < (std::pow(2, M))-1 ; field_count++){
    std::cout << "field : "s << field_count << " : "s  << field.at(field_count) << std::endl;
  }

  std::cout << "field.size : "s << field.size() << std::endl;
}

void gf::show_conjugate_root(){ // メンバ関数

  printf(">>>>>>>>>> >>>>>>>>>> show_conjugate_root\n");

  for(count_0 = 0; count_0 < conjugate_root.size(); ++count_0){

    for(count_1 = 0; count_1 < conjugate_root.at(count_0).size(); ++count_1){

      std::cout << conjugate_root.at(count_0).at(count_1) << ","s ;
    }
    std::cout << std::endl;
  }
}

void gf::show_mini_poly(){ // メンバ関数

  printf(">>>>>>>>>> >>>>>>>>>> show_mini_poly\n");

  for(count_0 = 0; count_0 < mini_poly.size(); ++count_0){

    printf("%d,", mini_poly.at(count_0));
  }
  std::cout << std::endl;
}

void gf::show_generate_poly(){ // メンバ関数

  printf(">>>>>>>>>> >>>>>>>>>> show_generate_poly\n");
  printf("%d\n", generate_poly);
}

inline int check_conjugate_root(std::vector<std::vector<unsigned int>> conjugate_root, int conjugate_alpha){

  unsigned int count_1;

  int conjugate_root_hit = 0;

  for(count_1 = 0 ; count_1 < conjugate_root.size(); ++count_1){

    auto result = std::find(conjugate_root.at(count_1).begin(), conjugate_root.at(count_1).end(), conjugate_alpha);

    if(result != conjugate_root.at(count_1).end()){

      conjugate_root_hit = 1;
      break;
    }

  }//for
  return conjugate_root_hit;
}

inline int get_max_degree(std::vector<unsigned int> tmp_poly0, std::vector<unsigned int> tmp_poly1 ){

  int max_degree;

  if(tmp_poly0.size() > tmp_poly0.size()){ // NG!!!!!!!!!!!!!!!!!!!!!!!!!
    max_degree = tmp_poly0.size();
  }
  else{
    max_degree = tmp_poly1.size();
  }

  return max_degree;
}

inline void init_make_conjugate_root(int &conjugate_root_count_1, int &new_flag, std::vector<std::vector<unsigned int>> &conjugate_root){

  conjugate_root_count_1 = 0;
  new_flag               = 0;
  conjugate_root.emplace_back();//配列拡大
}

void make_conjugate_root(int &M, std::vector<std::vector<unsigned int>> &conjugate_root){
  int field_count;
  int conjugate_root_hit;
  int new_flag;
  int conjugate_alpha;
  int conjugate_root_count_1;

  init_make_conjugate_root(conjugate_root_count_1, new_flag, conjugate_root);

  for(field_count = 1 ; field_count < (std::pow(2, M)-1); field_count++){

    conjugate_alpha = field_count;

    while(1){
      conjugate_root_hit = 0;

      if(conjugate_root.size() != 0){

        conjugate_root_hit = check_conjugate_root(conjugate_root,  conjugate_alpha);

        if(conjugate_root_hit == 1){break;}
        else{
          new_flag = 0;

          while(1){

            conjugate_root_hit = check_conjugate_root(conjugate_root,  conjugate_alpha);
	    
            if(conjugate_root_hit == 0){

              if(new_flag == 0){

                if( (conjugate_root.size() == 1 && conjugate_root.at(0).size() == 0) ){

                  //std::cout << "1/0"s << "\n"s;
                }
                else{
                  conjugate_root.emplace_back();
                  ++conjugate_root_count_1;
                }
              }
	      
              conjugate_root.at(conjugate_root_count_1).push_back(conjugate_alpha);

              new_flag = 1;

              conjugate_alpha = std::fmod(conjugate_alpha*=2, (std::pow(2, M)-1));
            }
            else{
              break;
            }
          }
        }
      }
    }
  }
}

void f_up_degree(int &ss_a, int &ss_x, std::vector<std::vector<signed int>> &pre_poly_b){

  if(pre_poly_b.at(ss_a).at(0) != -1){

    pre_poly_b.at(ss_x).at(0) = 1;
  }
  pre_poly_b.at(ss_x).insert(pre_poly_b.at(ss_x).begin(),-1);

  pre_poly_b.at(ss_a).insert(pre_poly_b.at(ss_a).begin(),-1);
}

void f_init_set_poly(std::vector<std::vector<unsigned int>> &conjugate_root, int &ss_a, int &ss_x,
		     unsigned int                           &count_1,
		     unsigned int                           &count_2,
		     std::vector<std::vector<signed int>>   &pre_poly){

  //ここで初回の配列にいれる
  pre_poly.emplace_back();         // 配列拡大
  pre_poly.at(ss_a).push_back(conjugate_root.at(count_1).at(count_2)); // 共役根を入れる
  pre_poly.at(ss_a).push_back(-1); // 空であれば無条件で入れる
  pre_poly.emplace_back();         // 配列拡大
  pre_poly.at(ss_x).push_back(-1); // 空であれば無条件でいれる
  pre_poly.at(ss_x).push_back(1);  // 空であれば無条件でいれる
}

void f_array_cpy(std::vector<std::vector<signed int>> &array_0,
		 std::vector<std::vector<signed int>> &array_1){

  unsigned int count_0, count_1;

  for(count_0 = 0; count_0 < array_0.size(); ++count_0){

    array_1.emplace_back();

    for(count_1 = 0; count_1 < array_0.at(count_0).size(); ++count_1){

      array_1.at(count_0).push_back(array_0.at(count_0).at(count_1));
    }
  }
}

void f_mul_alpha(int &M, int &ss_a, signed int &tmp,
		 std::vector<std::vector<signed int>> &pre_poly_b_tmp){
  
  unsigned int count_0;
  int        result;
  int        M_tmp = (std::pow(2, M))-1;
  
  for(count_0 = 0; count_0 < pre_poly_b_tmp.at(ss_a).size(); ++count_0){

    if(pre_poly_b_tmp.at(ss_a).at(count_0) == -1){

      pre_poly_b_tmp.at(ss_a).at(count_0) = tmp;
    }
    else{

      result = pre_poly_b_tmp.at(ss_a).at(count_0) + tmp;
      
      if(result >= M_tmp){

        result = result % M_tmp;
      }
      pre_poly_b_tmp.at(ss_a).at(count_0) = result;
    }
  }
}

void f_add_poly_ary(int &ss_a, int &ss_x,
		    std::vector<std::vector<signed int>> &pre_poly_b,
		    std::vector<std::vector<signed int>> &pre_poly_b_tmp
		    ){

  unsigned int count_0;

  for(count_0 = 0; count_0 < pre_poly_b_tmp.at(ss_x).size(); ++count_0){

    if( (pre_poly_b.at(ss_x).at(count_0) == -1 ) && ( pre_poly_b_tmp.at(ss_x).at(count_0) == -1) ){

      pre_poly_b.at(ss_x).at(count_0) = -1;
    }
    else{

      pre_poly_b.at(ss_x).at(count_0) = 1;
    }
  }

  gf_alpha gf_a1(0); // instance
  gf_alpha gf_a2(0); // instance
  gf_alpha gf_a3 = gf_a1 + gf_a2; // instance

  for(count_0 = 0; count_0 < pre_poly_b_tmp.at(ss_a).size(); ++count_0){

    if( (pre_poly_b_tmp.at(ss_a).at(count_0) == -1 ) && (pre_poly_b.at(ss_a).at(count_0) == -1 ) ){

      pre_poly_b.at(ss_a).at(count_0) = -1;
    }
    else if(pre_poly_b_tmp.at(ss_a).at(count_0) == -1){

    }
    else if(pre_poly_b.at(ss_a).at(count_0) == -1){

      pre_poly_b.at(ss_a).at(count_0) = pre_poly_b_tmp.at(ss_a).at(count_0);
    }
    else{
      if(pre_poly_b.at(ss_a).at(count_0) == pre_poly_b_tmp.at(ss_a).at(count_0)){

        pre_poly_b.at(ss_x).at(count_0) = -1;
      }
      gf_a1.set(pre_poly_b.at(ss_a).at(count_0));
      gf_a2.set(pre_poly_b_tmp.at(ss_a).at(count_0));
      gf_a3 = gf_a1 + gf_a2;
      pre_poly_b.at(ss_a).at(count_0) = gf_a3.get();
    }
  }
}

void show_array(const char *comment_tmp, std::vector<std::vector<signed int>> &tmp_array){

  printf("========== ==========\n");

  printf("show_array : %s\n", comment_tmp);

  unsigned int count_0;
  signed int count_1;

  for(count_0 = 0; count_0 < tmp_array.size(); ++count_0){

    std::cout << "array_" << count_0 << " : " << tmp_array.at(count_0).size() << " : ";

    for(count_1 = tmp_array.at(count_0).size()-1 ; count_1 >= 0 ; --count_1){

      printf("%4d", tmp_array.at(count_0).at(count_1));
    }
    std::cout << std::endl;
  }
  // printf("========== ==========\n");
}

/*
void show_unsigned_array(const char *comment_tmp, std::vector<std::vector<unsigned int>> &tmp_array){

  printf("========== ==========\n");

  printf("show_array : %s\n", comment_tmp);

  unsigned int count_0;
  unsigned int count_1;

  for(count_0 = 0; count_0 < tmp_array.size(); ++count_0){

    std::cout << "array_" << count_0 << " : " << tmp_array.at(count_0).size() << " : ";

    for(count_1 = tmp_array.at(count_0).size()-1 ; count_1 >= 0 ; --count_1){

      printf("%4d", tmp_array.at(count_0).at(count_1));
    }
    std::cout << std::endl;
  }

  // printf("========== ==========\n");
}
*/


void f_array2min_poly(int &ss_a, int &ss_x,
		      std::vector<std::vector<signed int>> &pre_poly_b,
		      std::vector<unsigned int> &mini_poly){

  unsigned int  count_0;
  std::string pre_mini_poly = "";;

  for(count_0 = 0; count_0 < pre_poly_b.at(ss_a).size() ; ++count_0){

    if(count_0 == 0){

      if( (pre_poly_b.at(ss_a).at(count_0) == 0) && (pre_poly_b.at(ss_x).at(count_0) == -1) ){

        pre_mini_poly.append("1");
      }
      else{
        printf("========== ========== make mini polynominal ERROR\n");
        break;
      }
    }
    else{
      if(  (pre_poly_b.at(ss_x).at(count_0) == 1) &&
           ( (pre_poly_b.at(ss_a).at(count_0) == 0) || (pre_poly_b.at(ss_a).at(count_0) == -1) ) ){

        pre_mini_poly.append("1");
      }
      else{
        if( (pre_poly_b.at(ss_a).at(count_0) == -1) && (pre_poly_b.at(ss_x).at(count_0) == -1)){

          pre_mini_poly.append("0");
        }
        else{
          printf("========== ========== make mini polynominal ERROR\n");
          break;
        }
      }
    }
  }
  std::reverse(pre_mini_poly.begin(), pre_mini_poly.end());
  unsigned int tmp = std::stoi(pre_mini_poly, nullptr, 2);
  mini_poly.push_back( tmp );
}

void get_bin_ary(unsigned int &mini_poly, std::vector<unsigned int> &result){

  unsigned int quotient;  // 商
  unsigned int remainder; // 余り

  quotient = mini_poly;
    
  while( quotient > (2-1) ){

    remainder = quotient % 2;
    quotient  = quotient / 2;

    result.push_back(remainder);
  }
  result.push_back(quotient);
}

void f_poly_mul_expand(std::vector<unsigned int> &tmp_bin_a,
		       std::vector<unsigned int> &tmp_bin_b,
		       std::vector<std::vector<unsigned int>> &tmp_generate_poly,
		       unsigned int &max_length){

  unsigned int count_0;
  unsigned int count_1 = 0;
  
  for(count_0 = 0; count_0 < tmp_bin_a.size() ;++count_0 ){ // a を回す 掛け算をして二次元にバラす

    if(tmp_bin_a.at(count_0) == 1){ // a が 1 の時、count_0 分をシフトして b を格納

      tmp_generate_poly.emplace_back(); // 拡大

      tmp_generate_poly.at(count_1).insert( tmp_generate_poly.at(count_1).begin(), count_0 ,0);// 0 を count_0 個挿入する

      tmp_generate_poly.at(count_1).insert( tmp_generate_poly.at(count_1).end(),
					    tmp_bin_b.begin(),
					    tmp_bin_b.end()       // tmp_bin_b を挿入
					    );

      max_length = tmp_generate_poly.at(count_1).size();

      ++count_1;
    }
  }
}

void f_vector_to_integer(std::vector<unsigned int> &tmp_generate_poly_ary,
			 std::string               &result,
			 unsigned int              &generate_poly){

  unsigned int count_0;

  for(count_0 = 0; count_0 < tmp_generate_poly_ary.size() ; ++count_0 ){

    if( tmp_generate_poly_ary.at(count_0) == 1){
      result = result + "1";
    }
    else{
      result = result + "0";
    }
  }
  generate_poly = std::stoi(result, 0, 2);
}

void f_v_count(std::vector<std::vector<unsigned int>> &tmp_generate_poly,
	       unsigned int &v_position,
	       unsigned int &bit_count){

  unsigned int count_0;
  
  for(count_0 = 0; count_0 < tmp_generate_poly.size(); ++count_0 ){ // 0 to 2

    //    printf(">>>>>>>>>> : %d : %d\n", v_position, count_0);

    // f_get_bit_count
    int err_flag_0 = 0;

    try{ tmp_generate_poly.at(count_0).at(v_position); } catch(std::out_of_range){ err_flag_0 = 1; }
       
    if( err_flag_0 == 0 ){

      if(tmp_generate_poly.at(count_0).at(v_position) == 1){
	      
        ++bit_count;
      }
    }
  }
}

void f_poly_mul_narrow(unsigned int                   &max_length,
		       std::vector<std::vector<unsigned int>> &tmp_generate_poly,
		       std::vector<unsigned int>              &tmp_generate_poly_ary){

  unsigned int count_0;

  for(count_0 = 0; count_0 < max_length; ++count_0 ){

    unsigned int bit_count  = 0;

    f_v_count(tmp_generate_poly, count_0, bit_count);

    // f_store
    if( (bit_count %2) == 1){ tmp_generate_poly_ary.push_back(1); }
    else                    { tmp_generate_poly_ary.push_back(0); }
  }
  std::reverse(tmp_generate_poly_ary.begin(), tmp_generate_poly_ary.end());
}

void gf::make_generate_poly(){

  //  std::cout << "--- make_poly_make ---\n"s;

  //  printf("%d\n", t);

  std::vector<std::vector<unsigned int>> tmp_generate_poly;
  unsigned int                           count_0;
  unsigned int                           max_length;
  std::vector<unsigned int>              tmp_bin_a;
  std::vector<unsigned int>              tmp_bin_b;
  std::vector<unsigned int>              tmp_generate_poly_ary;

  tmp_generate_poly.clear();

  generate_poly = 0;

  for(count_0 = 0 ; count_0 < t ; ++count_0 ){

    // printf(">>>>> : %d\n", mini_poly.at(count_0));

    if(tmp_bin_a.size() == 0){

      get_bin_ary( mini_poly.at(count_0), tmp_bin_a );
    }
    else{

      max_length = 0;

      get_bin_ary( mini_poly.at(count_0), tmp_bin_b ); // bをセット

      // poly a {tmp_bin_a};
      // poly b {tmp_bin_b};
      // a = a * b;
      f_poly_mul_expand(tmp_bin_a, tmp_bin_b, tmp_generate_poly, max_length);
      f_poly_mul_narrow(max_length, tmp_generate_poly, tmp_generate_poly_ary);

      tmp_bin_a = tmp_generate_poly_ary;
      tmp_bin_b.clear();

    }// else
  
  }// for

  std::string tmp_generate_str = "";

  f_vector_to_integer(tmp_generate_poly_ary, tmp_generate_str, generate_poly);

  //  std::cout << tmp_generate_str << "\n";
}

void gf::make_min_polynominal(){ // 生成多項式生成

  std::cout << "--- make_min_polynominal ---\n"s;

  // 共役根を生成する
  make_conjugate_root(M, conjugate_root );

  std::cout << "field.size : " << field.size() << "\n";

  std::vector<unsigned int> tmp_poly0;
  std::vector<unsigned int> tmp_poly1;
  std::vector<unsigned int> result_poly;

  //多項式展開

  tmp_poly0.push_back(0);
  tmp_poly0.push_back(field.at(conjugate_root.at(1).at(2)));
  tmp_poly1.push_back(0);
  tmp_poly1.push_back(field.at(conjugate_root.at(1).at(1)));

  // std::cout << "tmp_poly0 : " << tmp_poly0.at(0) << " : " << tmp_poly0.at(1) << "\n";
  // std::cout << "tmp_poly1 : " << tmp_poly1.at(0) << " : " << tmp_poly1.at(1) << "\n";

  tmp_poly1.push_back(0);
  // std::cout << "tmp_poly1 : " << tmp_poly1.at(2) << " : " << tmp_poly1.at(1) << " : " << tmp_poly1.at(0) << "\n";

  std::vector<std::vector<signed int>> pre_poly_a;
  std::vector<std::vector<signed int>> pre_poly_b;
  std::vector<std::vector<signed int>> pre_poly_b_tmp;

  int ss_a = 0; //添字subscript_alpha
  int ss_x = 1; //添字 subscript_x


  for(count_0 = 0; count_0 < conjugate_root.size(); ++count_0){

    for(count_1 = 0; count_1 < conjugate_root.at(count_0).size(); ++count_1){

      // printf("---------- ---------- count_0 count_1 : %d %d\n", count_0, count_1);
      
      if(pre_poly_a.size() == 0){
        f_init_set_poly(conjugate_root, ss_a, ss_x, count_0, count_1, pre_poly_a);
      }
      else if(pre_poly_b.size() == 0){
        f_init_set_poly(conjugate_root, ss_a, ss_x, count_0, count_1, pre_poly_b);
      }

      if((pre_poly_a.size() != 0) && (pre_poly_b.size() != 0) ){

        f_array_cpy(pre_poly_b, pre_poly_b_tmp);

        f_up_degree(ss_a, ss_x, pre_poly_b);

        f_mul_alpha(M, ss_a, pre_poly_a.at(ss_a).at(0), pre_poly_b_tmp);

        f_add_poly_ary(ss_a, ss_x, pre_poly_b, pre_poly_b_tmp);

        pre_poly_a.clear();
        pre_poly_b_tmp.clear();
      }
    }

    f_array2min_poly(ss_a, ss_x, pre_poly_b, mini_poly);

    // show_array("pre_poly_b", pre_poly_b); // ==========
    pre_poly_b.clear();

  }
}


template <typename T1, typename T2>
void ary_to_bitset( T1 &ary,
		    T2 &result_bitset){

  for( unsigned int count_0 = 0; count_0 < (ary.size()-1) ; ++count_0){

    result_bitset.set(count_0 , ary.at(count_0) );
  }
}

template <typename T1, typename T2, typename T3, typename T4, typename T5, typename T6>
void generate_parity(T1 &M,
		     T2 &send_dat_bit_size,
		     T3 &send_dat_bitset,
		     T4 &generate_poly_bit,
		     T5 &generate_poly_bitset,
		     T6 &lfsr){

  std::random_device seed_gen;
  std::mt19937 engine(seed_gen());
  std::uniform_int_distribution<> dist(0, 1);

  for( unsigned int i = 0; i < send_dat_bit_size; ++i){
    send_dat_bitset.set (0, dist(engine) );
    send_dat_bitset  <<= 1;
  }

  ary_to_bitset(generate_poly_bit, generate_poly_bitset );

  make_parity(M, generate_poly_bitset, send_dat_bitset, lfsr );
}

void gf::make_send_dat(){ //送信データとパリティを生成する

  std::cout << "--- make_send_dat ---\n"s;

  std::vector<unsigned int> generate_poly_bit;

  unsigned int parity_bit_size;
  unsigned int send_dat_bit_size;

  // generape_poly の次数を調べる、２進数に変換すればわかる
  get_bin_ary( generate_poly, generate_poly_bit );

  std::cout << generate_poly_bit.size() << std::endl;
  // printf("%d\n", generate_poly_bit.size());


  // 送信データをランダムで生成する
  // ビット数は、2^M-1 - generate_poly のビット数 - 

  parity_bit_size   = generate_poly_bit.size()-1;
  send_dat_bit_size = ((std::pow(2, M))-1) - parity_bit_size;

  printf("parity_bit_size : %d\n", parity_bit_size);
  printf("send_bit_size   : %d\n", send_dat_bit_size);

  std::bitset <3>  generate_poly_bitset3;  std::bitset <2>  send_dat_bitset2;
  std::bitset <4>  generate_poly_bitset4;  std::bitset <3>  send_dat_bitset3;
  std::bitset <5>  generate_poly_bitset5;  std::bitset <4>  send_dat_bitset4;
  std::bitset <6>  generate_poly_bitset6;  std::bitset <5>  send_dat_bitset5;
  std::bitset <7>  generate_poly_bitset7;  std::bitset <6>  send_dat_bitset6;
  std::bitset <8>  generate_poly_bitset8;  std::bitset <7>  send_dat_bitset7;
  std::bitset <9>  generate_poly_bitset9 ; std::bitset <8>  send_dat_bitset8;
  std::bitset <10> generate_poly_bitset10; std::bitset <9>  send_dat_bitset9;
  std::bitset <11> generate_poly_bitset11; std::bitset <10> send_dat_bitset10;
  std::bitset <12> generate_poly_bitset12; std::bitset <11> send_dat_bitset11;
  std::bitset <13> generate_poly_bitset13; std::bitset <12> send_dat_bitset12;
  std::bitset <14> generate_poly_bitset14; std::bitset <13> send_dat_bitset13;
  std::bitset <15> generate_poly_bitset15; std::bitset <14> send_dat_bitset14;
  std::bitset <16> generate_poly_bitset16; std::bitset <15> send_dat_bitset15;
  std::bitset <17> generate_poly_bitset17; std::bitset <16> send_dat_bitset16;
  std::bitset <18> generate_poly_bitset18; std::bitset <17> send_dat_bitset17;
  std::bitset <19> generate_poly_bitset19; std::bitset <18> send_dat_bitset18;
  std::bitset <20> generate_poly_bitset20; std::bitset <19> send_dat_bitset19;
  std::bitset <21> generate_poly_bitset21; std::bitset <20> send_dat_bitset20;

  std::string     generate_poly_string;
  
  // ary_to_bitset( generate_poly_bit, generate_poly_bitset8 ); // 生成多項式を bitset 化

  // for( int i = 0; i < send_dat_bit_size; ++i){send_dat_bitset.set(0, dist(engine)); send_dat_bitset <<= 1;}

  // std::bitset<7> send_dat_bitset {"1101100"};

  switch( send_dat_bit_size ){
  case 2  : generate_parity(M, send_dat_bit_size, send_dat_bitset2 , generate_poly_bit, generate_poly_bitset3 , lfsr3 ); break;
  case 3  : generate_parity(M, send_dat_bit_size, send_dat_bitset3 , generate_poly_bit, generate_poly_bitset4 , lfsr4 ); break;
  case 4  : generate_parity(M, send_dat_bit_size, send_dat_bitset4 , generate_poly_bit, generate_poly_bitset5 , lfsr5 ); break;
  case 5  : generate_parity(M, send_dat_bit_size, send_dat_bitset5 , generate_poly_bit, generate_poly_bitset6 , lfsr6 ); break;
  case 6  : generate_parity(M, send_dat_bit_size, send_dat_bitset6 , generate_poly_bit, generate_poly_bitset7 , lfsr7 ); break;
  case 7  : generate_parity(M, send_dat_bit_size, send_dat_bitset7 , generate_poly_bit, generate_poly_bitset8 , lfsr8 ); break;//
  case 8  : generate_parity(M, send_dat_bit_size, send_dat_bitset8 , generate_poly_bit, generate_poly_bitset9 , lfsr9 ); break;
  case 9  : generate_parity(M, send_dat_bit_size, send_dat_bitset9 , generate_poly_bit, generate_poly_bitset10, lfsr10); break;
  case 10 : generate_parity(M, send_dat_bit_size, send_dat_bitset10, generate_poly_bit, generate_poly_bitset11, lfsr11); break;
  case 11 : generate_parity(M, send_dat_bit_size, send_dat_bitset11, generate_poly_bit, generate_poly_bitset12, lfsr12); break;
  case 12 : generate_parity(M, send_dat_bit_size, send_dat_bitset12, generate_poly_bit, generate_poly_bitset13, lfsr13); break;
  case 13 : generate_parity(M, send_dat_bit_size, send_dat_bitset13, generate_poly_bit, generate_poly_bitset14, lfsr14); break;
  case 14 : generate_parity(M, send_dat_bit_size, send_dat_bitset14, generate_poly_bit, generate_poly_bitset15, lfsr15); break;
  case 15 : generate_parity(M, send_dat_bit_size, send_dat_bitset15, generate_poly_bit, generate_poly_bitset16, lfsr16); break;
  case 16 : generate_parity(M, send_dat_bit_size, send_dat_bitset16, generate_poly_bit, generate_poly_bitset17, lfsr17); break;
  case 17 : generate_parity(M, send_dat_bit_size, send_dat_bitset17, generate_poly_bit, generate_poly_bitset18, lfsr18); break;
  case 18 : generate_parity(M, send_dat_bit_size, send_dat_bitset18, generate_poly_bit, generate_poly_bitset19, lfsr19); break;
  case 19 : generate_parity(M, send_dat_bit_size, send_dat_bitset19, generate_poly_bit, generate_poly_bitset20, lfsr20); break;
  case 20 : generate_parity(M, send_dat_bit_size, send_dat_bitset20, generate_poly_bit, generate_poly_bitset21, lfsr21); break;
  }


  //  std::cout << "send_dat_bitset : " << send_dat_bitset << "\n"s;

  // 送信データをLFSRに入れてパリティを生成する

  // 次数に合わせて lfsr に入れる

  // (2^M -1) 回　回す

  //　MATLABと比較する
}




/*
void gf::show_send_dat( &M ){ // メンバ関数

  printf(">>>>>>>>>> >>>>>>>>>> show_send_dat\n");
  //  std::cout << send_dat_bitset[0] << "\n"s ;
  std::cout << send_dat_bit_size << "\n"s ;
}
*/
/*
void gf::show_send_parity( &M ){ // メンバ関数

  printf(">>>>>>>>>> >>>>>>>>>> show_send_parity\n");

  std::cout << lfsr8 << "\n"s ;
}
*/
