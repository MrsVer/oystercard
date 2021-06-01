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
        expect{ subject.top_up(100)}.to raise_error "Balance cannot exceed 90"
    end
 end
end

