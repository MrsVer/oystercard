class Oystercard
    
STARTING_BALANCE = 0
MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 5

attr_reader :balance

    def initialize
        @balance = STARTING_BALANCE
    end

    def top_up(top_up_amount)
      fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + top_up_amount > MAXIMUM_BALANCE
      @balance += top_up_amount
    end

    def deduct(amount)
        @balance -= amount
    end

    def in_journey?
        @in_journey
    end

    def touch_in
        fail "Insufficient balance to touch in" if @balance < MINIMUM_BALANCE
        @in_journey = true
    end
    
    def touch_out
        @in_journey = false
        @balance -= MINIMUM_BALANCE
        
    end
end
