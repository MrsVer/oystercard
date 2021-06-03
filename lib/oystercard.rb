class Oystercard
    
STARTING_BALANCE = 0
MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 5
MINIMUM_CHARGE = 1

attr_reader :balance, :entry_station

    def initialize
        @balance = STARTING_BALANCE
        @entry_station = nil
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
        @in_journey = true
    end
    
    def touch_out
        deduct(MINIMUM_CHARGE)
        @in_journey = false
    end

    private
    def deduct(amount)
        @balance -= amount
    end
end
