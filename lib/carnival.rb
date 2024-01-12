class Carnival
  attr_reader :duration
  attr_accessor :rides

  def initialize(days)
    @duration = days
    @rides = []
  end

  def add_ride(ride)
    rides.push(ride)
  end

  def most_popular_ride
    rides.max_by { |ride| ride.rider_log.values.sum }
  end

  def most_profitable_ride
    rides.max_by { |ride| ride.total_revenue }
  end

  def total_revenue
    rides.sum { |ride| ride.total_revenue }
  end

  def unique_visitors
    results = {}

    rides.each do |ride|
      ride.rider_log.each do |visitor, ridden|
        if !results.has_key?(visitor)
          results[visitor] = "visited"
        end
      end
    end

    results.keys
  end

  def summary
    {
      visitor_count: unique_visitors.length,
      revenue_earned: total_revenue,
      visitors: unique_visitors,
      rides: @rides
    }
  end
end
