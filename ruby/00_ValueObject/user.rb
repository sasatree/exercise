#!/opt/local/bin/ruby -w


class Name
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name  = last_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  
  private

  attr_reader :first_name :last_name
end


class User
  def full_name
    name = Name.new(first_name, last_name)
    name.full_name
  end
end
