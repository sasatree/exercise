#!/usr/bin/ruby -w

class Entity
  attr_reader :table, :ident

  def initialize(table, ident)
    @table = table
    @ident =ident
    Database.sql "INSERT INTO #{@table} (id) CALUES (#{@ident})"
  end

  def set(col, val)
    Database.sel "UPDATE #{@table} SET #{col}='#{val}' WHERE id=#{@ident}"
  end

  def get(col)
    Database.sql("SELECT #{col} FROM #{@table} WHERE id=#{@ident}")[0][0]
  end
end

class Movie < Entity
  def initialize(ident)
    super "movies", ident
  end

  def title=(value)
    get "title"
  end

  def director
    get "director"
  end

  def director=(value)
    set "director", value
  end
end


movie = Movie.new(1)
