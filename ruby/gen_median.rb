#!/usr/bin/ruby -w

median_lst = Hash.new { |h,k| h[k] = {} }

class Median
  attr_reader :bit

  def initialize(value)
    @bit = value
  end
end


p median_lst["A"][0].class

median_lst["A"][0] = Median.new(1)

p median_lst["A"][0].class

median_lst["A"][1] = Median.new("A111")
median_lst["A"][2] = Median.new("A222")
median_lst["B"][1] = Median.new("B111")
median_lst["B"][2] = Median.new("B222")
median_lst["B"][3] = Median.new("B222")
median_lst["B"][10] = Median.new("B10")
median_lst["E"][1] = Median.new("E1")

p median_lst["A"][1].class


median_lst.each do |func_num,x|


  median_lst[func_num].each do |sig_num,y|



    p median_lst[func_num][sig_num].bit()



  end
end
