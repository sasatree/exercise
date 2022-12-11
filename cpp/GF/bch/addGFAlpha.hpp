class gf_alpha{
private:
  unsigned int               count_0;
  std::vector<int>::iterator itr;
  unsigned int               vec_tmp;
  unsigned int               alp_tmp;
public:

  gf_alpha operator +(gf_alpha & r){ // + の処理の内容

    gf_alpha gf_a;

    gf_a.vec_tmp = this->vec_tmp ^ r.vec_tmp; // gf_a の中に保持、gf_aを返す

    for(count_0 = 0; count_0 < field.size() ; ++count_0){

      if(field.at(count_0) == gf_a.vec_tmp){
        break;
      }
    }

    if(count_0 == field.size()){

      gf_a.alp_tmp = -1;
    }
    else{
      gf_a.alp_tmp = count_0;
    }
    return gf_a;
  }

  gf_alpha(int x = 0){vec_tmp = field.at(x);} // 初期値セット

  signed int get(){ // vec_tmp返す

    return alp_tmp;
  }
  
  void set(int x) {
    vec_tmp = field.at(x); // 初期化
  }
};
