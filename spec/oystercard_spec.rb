require "oystercard"

describe Oystercard do
  let(:min_balance) { Oystercard::MINIMUM_BALANCE }
  
    it "has an initialized balanced of 0" do
     expect(subject.balance).to eq 0
    end

  describe '#top_up' do
    it "top up the balance" do
      top_up_balance = 10
      expect( subject.top_up(top_up_balance)).to eq top_up_balance
    end

    it 'does not exceed top up of 90' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end

 end

  describe '#deduct' do
    it 'deducts an amount from the balance' do
      subject.top_up(20)
      expect{ subject.deduct 10}.to change{ subject.balance }.by -10
    end
  end

  describe '#in_journey' do
    it 'is initially not in a journey' do
     expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it "can touch in" do
       subject.top_up(20)
       subject.touch_in
       expect(subject).to be_in_journey
    end

    it 'throws an error if insufficient funds' do
      expect { subject.touch_in }.to raise_error 'Insufficient balance to touch in'
    end
  end
  
  describe '#touch_out' do
    it "can touch out" do
      subject.touch_out
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end

