require './lib/dock'
require './lib/renter'
require './lib/boat'

RSpec.describe Dock do
  before(:each) do
    @dock    = Dock.new("The Rowing Dock", 3)
    @kayak_1 = Boat.new(:kayak, 20)
    @kayak_2 = Boat.new(:kayak, 20)
    @canoe   = Boat.new(:canoe, 25)
    @sup_1   = Boat.new(:standup_paddle_board, 15)
    @sup_2   = Boat.new(:standup_paddle_board, 15)
    @patrick = Renter.new("Patrick Star", "4242424242424242")
    @eugene  = Renter.new("Eugene Crabs", "1313131313131313")
    @dock.rent(@kayak_1, @patrick)
    @dock.rent(@kayak_2, @patrick)
    @dock.rent(@sup_1, @eugene)
    @kayak_1.add_hour
    @kayak_1.add_hour
    @sup_1.add_hour
    @sup_1.add_hour
    @sup_1.add_hour
    @sup_1.add_hour
    @sup_1.add_hour
  end

  it 'exists & has attributes' do
    expect(@dock.name).to eq("The Rowing Dock")
    expect(@dock.max_rental_time).to eq(3)
  end

  it 'can return rental_log' do
    expect(@dock.rental_log).to eq({
      @kayak_1 => @patrick,
      @kayak_2 => @patrick,
      @sup_1   => @eugene
    })
  end

  it 'can return a charge' do
    expect(@dock.charge(@kayak_1)).to eq({
      :card_number => "4242424242424242",
      :amount => 40
    })
    expect(@dock.charge(@sup_1)).to eq({
      :card_number => "1313131313131313",
      :amount => 45
    })
  end

  xit 'can return revenue' do
    # kayak_1 and kayak_2 are rented an additional hour
    @dock.log_hour
    @dock.rent(@canoe, @patrick)
    # kayak_1, kayak_2, and canoe are rented an additional hour
    @dock.log_hour
    # Revenue should not be generated until boats are returned
    expect(@dock.revenue).to eq(0)

    @dock.return(@kayak_1)
    @dock.return(@kayak_2)
    @dock.return(@canoe)
    # Revenue thus far
    expect(@dock.revenue).to eq(105)
    # Rent Boats out to a second Renter
    @dock.rent(@sup_1, @eugene)
    @dock.rent(@sup_2, @eugene)
    @dock.log_hour
    @dock.log_hour
    @dock.log_hour
    # Any hours rented past the max rental time don't factor into revenue
    @dock.log_hour
    @dock.log_hour
    @dock.return(@sup_1)
    @dock.return(@sup_2)
    # Total revenue
    expect(@dock.revenue).to eq(195)
  end
end
