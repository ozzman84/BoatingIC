require './lib/boat'
require './lib/renter'

RSpec.describe Boat do
  before(:each) do
    @kayak = Boat.new(:@kayak, 20)
  end

  it 'exists' do
    expect(@kayak).to be_a(Boat)
    expect(@kayak.type).to eq(:@kayak)
    expect(@kayak.price_per_hour).to eq(20)
  end

  it 'can return hours rented' do
    expect(@kayak.hours_rented).to eq(0)
    @kayak.add_hour
    @kayak.add_hour
    @kayak.add_hour
    expect(@kayak.hours_rented).to eq(3)
  end
end
