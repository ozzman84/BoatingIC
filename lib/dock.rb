class Dock
  attr_reader :name,
              :max_rental_time,
              :rental_log

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = Hash.new(0)
  end

  def rent(boat, renter)
    @rental_log[boat] = renter
  end

  def charge(boat)
    charge_hash = Hash.new(0)
    @rental_log.find do |key, value|
      charge_hash[:card_number] = value.credit_card_number if key == boat
    end
    @rental_log.find do |key, value|
      charge_hash[:amount] = [key.hours_rented, max_rental_time].min * key.price_per_hour if key == boat
    end
    charge_hash
  end
end
