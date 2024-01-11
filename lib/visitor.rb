class Visitor
  attr_reader :name, :height, :spending_money, :preferences

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money.delete_prefix("$").to_i
    @preferences = []
  end

  def add_preference(preference)
    preferences.push(preference)
  end

  def tall_enough?(height_in_inches)
    height >= height_in_inches
  end
end
