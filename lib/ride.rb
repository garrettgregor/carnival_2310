class Ride
  attr_reader :name, :min_height, :admission_fee, :excitement, :rider_log
  attr_accessor :total_revenue

  def initialize(ride)
    @name = ride[:name]
    @min_height = ride[:min_height]
    @admission_fee = ride[:admission_fee]
    @excitement = ride[:excitement]
    @total_revenue = 0
    @rider_log = Hash.new(0)
  end

  def board_rider(visitor)
    if can_ride?(visitor)
      rider_log[visitor] += 1
      visitor.spending_money -= admission_fee
      @total_revenue += admission_fee
    end
  end

  def can_ride?(visitor)
    visitor.height >= min_height &&
    visitor.preferences.include?(@excitement) &&
    visitor.spending_money >= admission_fee
  end
end
