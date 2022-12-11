#!/opt/local/bin/ruby -w
# coding: utf-8








require "csv"

CSV.foreach(ARGV[0]) do |row|


  if( row[0] == "〇" )

    p row
  end
end

