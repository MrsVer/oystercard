require './lib/station'

class Oystercard
    
STARTING_BALANCE = 0
MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 5
MINIMUM_CHARGE = 1

attr_reader :balance, :entry_station, :list_of_journeys

    def initialize
        @balance = STARTING_BALANCE
        @entry_station = nil
        @list_of_journeys = []
    end

    def top_up(top_up_amount)
      fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + top_up_amount > MAXIMUM_BALANCE
      @balance += top_up_amount
    end

    def in_journey?
        @in_journey
    end

    def touch_in(station)
        fail "Insufficient balance to touch in" if @balance < MINIMUM_CHARGE
        @entry_station = station
        @list_of_journeys << { @entry_station => 'on a train' }
        @in_journey = true
    end
    
    def touch_out(station)
        deduct(MINIMUM_CHARGE)
        @exit_station = station
        @list_of_journeys[0][@entry_station] = @exit_station
        @in_journey = false
    end

    private
    def deduct(amount)
        @balance -= amount
    end
end
