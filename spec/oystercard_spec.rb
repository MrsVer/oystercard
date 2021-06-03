require "oystercard"

describe Oystercard do
  let(:min_charge) { Oystercard::MINIMUM_CHARGE }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

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

  describe '#in_journey' do
    it 'is initially not in a journey' do
     expect(subject).not_to be_in_journey
    end

    it 'checks that touching in and out creates one journey' do
      subject.top_up(20)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.list_of_journeys).to eq([{entry_station => exit_station}])
  end

  it 'checks that the card has an empty list of journeys by default' do
    expect(subject.list_of_journeys).to eq []
  end

  describe '#touch_in' do
    it "can touch in" do
       subject.top_up(20)
       subject.touch_in(entry_station)
       expect(subject).to be_in_journey
    end

    it 'throws an error if insufficient funds' do
      expect { subject.touch_in(entry_station) }.to raise_error 'Insufficient balance to touch in'
    end

    it 'checks for an entry station when user touches in' do
      subject.top_up(20)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
  end
  
  describe '#touch_out' do
    it "can touch out" do
      subject.top_up(20)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

    it "Deduct money when touch out" do
      subject.top_up(20)
      subject.touch_in(entry_station)
    expect {subject.touch_out(exit_station)}.to change{ subject.balance }.by(-min_charge)
    end

    it 'deducts an amount from the balance' do
      subject.top_up(20)
      subject.touch_in(entry_station)
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by -min_charge
    end
  end

end
end
