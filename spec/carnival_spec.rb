require './lib/visitor'
require './lib/ride'
require './lib/carnival'

RSpec.describe Carnival do
  let!(:carnival1) { Carnival.new(14) }
  let!(:ride1) { Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle }) }
  let!(:visitor1) { Visitor.new('Bruce', 54, '$100') }
  let!(:visitor2) { Visitor.new('Tucker', 36, '$100') }
  let!(:visitor3) { Visitor.new('Penny', 64, '$100') }
  let!(:ride2) { Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle }) }
  let!(:ride3) { Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling }) }


  describe "#intialize" do
    it "exists without any rides and has a duration in days" do
      expect(carnival1).to be_a(Carnival)
      expect(carnival1.duration).to eq(14)
      expect(carnival1.rides).to eq([])
    end
  end

  describe "#add_ride" do
    it "adds rides to the carnival" do
      carnival1.add_ride(ride1)

      expect(carnival1.rides).to eq([ride1])

      carnival1.add_ride(ride2)
      carnival1.add_ride(ride3)

      expect(carnival1.rides).to eq([ride1, ride2, ride3])
    end
  end

  describe "#most_popular_ride" do
    it "returns the ride that has been riden the most amount of times by all visitors (not based on unique riders)" do
      carnival1.add_ride(ride1)
      carnival1.add_ride(ride2)
      carnival1.add_ride(ride3)

      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      visitor3.add_preference(:gentle)
      visitor1.add_preference(:thrilling)
      visitor2.add_preference(:thrilling)
      visitor3.add_preference(:thrilling)

      1.times { carnival1.rides[0].board_rider(visitor1) }
      2.times { carnival1.rides[1].board_rider(visitor2) }
      3.times { carnival1.rides[2].board_rider(visitor3) }

      expect(carnival1.most_popular_ride).to eq(carnival1.rides[2])
    end
  end

  describe "#most_profitable_ride" do
    it "returns the most profitable ride" do
      carnival1.add_ride(ride1)
      carnival1.add_ride(ride2)
      carnival1.add_ride(ride3)

      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      visitor3.add_preference(:gentle)
      visitor1.add_preference(:thrilling)
      visitor2.add_preference(:thrilling)
      visitor3.add_preference(:thrilling)

      1.times { carnival1.rides[0].board_rider(visitor1) }
      2.times { carnival1.rides[1].board_rider(visitor2) }
      3.times { carnival1.rides[2].board_rider(visitor3) }

      expect(carnival1.most_profitable_ride).to eq(carnival1.rides[1])
    end
  end

  describe "#total_revenue" do
    it "returns the total revnue earned from all rides" do
      carnival1.add_ride(ride1)
      carnival1.add_ride(ride2)
      carnival1.add_ride(ride3)

      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      visitor3.add_preference(:gentle)
      visitor1.add_preference(:thrilling)
      visitor2.add_preference(:thrilling)
      visitor3.add_preference(:thrilling)

      1.times { carnival1.rides[0].board_rider(visitor1) }
      2.times { carnival1.rides[1].board_rider(visitor2) }
      3.times { carnival1.rides[2].board_rider(visitor3) }

      expect(carnival1.total_revenue).to eq(17)
    end
  end

  describe "#unique_visitors" do
    it "returns a list of unique visitors to the carnival" do
      carnival1.add_ride(ride1)
      carnival1.add_ride(ride2)
      carnival1.add_ride(ride3)

      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      visitor3.add_preference(:gentle)
      visitor1.add_preference(:thrilling)
      visitor2.add_preference(:thrilling)
      visitor3.add_preference(:thrilling)

      1.times { carnival1.rides[0].board_rider(visitor1) }
      2.times { carnival1.rides[1].board_rider(visitor2) }
      3.times { carnival1.rides[2].board_rider(visitor3) }

      result = [visitor1, visitor2, visitor3]

      expect(carnival1.unique_visitors).to eq(result)
    end
  end

  describe "#summary" do
    it "returns a summary hash" do
      carnival1.add_ride(ride1)
      carnival1.add_ride(ride2)
      carnival1.add_ride(ride3)

      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)
      visitor3.add_preference(:gentle)
      visitor1.add_preference(:thrilling)
      visitor2.add_preference(:thrilling)
      visitor3.add_preference(:thrilling)

      1.times { carnival1.rides[0].board_rider(visitor1) }
      2.times { carnival1.rides[1].board_rider(visitor2) }
      3.times { carnival1.rides[2].board_rider(visitor3) }

      result = {
        visitor_count: 3,
        revenue_earned: 17,
        visitors: [visitor1, visitor2, visitor3],
        rides: [ride1, ride2, ride3]
      }

      expect(carnival1.summary).to eq(result)
    end
  end
end
