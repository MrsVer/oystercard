require "oystercard"

describe Oystercard do
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
    it 'deduct money from the card' do
    card = Oystercard.new
    card.top_up(20)
    card.deduct(10)
    expect(card.balance).to eq 10
     end
    end
end

