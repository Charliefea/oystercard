require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:balance_limit) { Oystercard::BALANCE_LIMIT }

  it 'has a default balance of 0' do
    expect(oystercard.balance).to eq 0
  end

  describe '#top_up' do
    it 'should be able to be topped up' do
      expect { oystercard.top_up(5) }.to change { oystercard.balance }.from(0).to(5)
    end
    it 'should prevent balance from exceeding £90' do
      oystercard.top_up(balance_limit)
      expect { oystercard.top_up(1) }.to raise_error {"Your balance cannot exceed £#{balance_limit}"}
    end
  end

  describe '#deduct' do
    it 'should be able to have balance deducted' do
      oystercard.top_up(balance_limit)
      expect { oystercard.deduct(5) }.to change { oystercard.balance }.from(balance_limit).to(balance_limit-5)
    end
  end

  describe '#touch_in' do
    it 'should change the in journey status to true' do
      oystercard.top_up(balance_limit)
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end
    it 'should raise an exception when trying to touch in with balance less than £1' do
      expect{ oystercard.touch_in }.to raise_error { "Insufficient funds" }
    end
  end

  describe '#touch_out' do
    it 'should change the in journey status to false' do
      oystercard.top_up(balance_limit)
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end
    it 'should reduce the balance by the fare' do
      oystercard.top_up(balance_limit)
      oystercard.touch_in
      expect { oystercard.touch_out }.to change { oystercard.balance }.from(balance_limit).to(balance_limit-1)
    end
  end


  describe '#in_journey?' do
    it 'should be false before touching in' do
      expect(oystercard).not_to be_in_journey
    end
  end

end
