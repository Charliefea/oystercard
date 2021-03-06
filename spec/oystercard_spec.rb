require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:balance_limit) { Oystercard::BALANCE_LIMIT }

  it 'has a default balance of 0' do
    expect(oystercard.balance).to eq 0
  end

  it 'has a default entry station of nil' do
    expect(oystercard.entry_station).to eq nil
  end

  describe '#top_up' do
    it 'should be able to be topped up' do
      expect { oystercard.top_up(balance_limit) }.to change { oystercard.balance }.by(balance_limit)
    end
    it 'should prevent balance from exceeding £90' do
      oystercard.top_up(balance_limit)
      expect { oystercard.top_up(1) }.to raise_error {"Your balance cannot exceed £#{balance_limit}"}
    end
  end

  describe '#touch_in' do
    it 'should change the in journey status to true' do
      oystercard.top_up(balance_limit)
      oystercard.touch_in(:station)
      expect(oystercard).to be_in_journey
    end
    it 'should raise an exception when trying to touch in with balance less than £1' do
      expect{ oystercard.touch_in(:station) }.to raise_error { "Insufficient funds" }
    end
    it 'should remember the station touched in at' do
      oystercard.top_up(balance_limit)
      oystercard.touch_in(:station)
      expect(oystercard.entry_station).to eq :station
    end
  end

  describe '#touch_out' do
    before do
      oystercard.top_up(balance_limit)
      oystercard.touch_in(:station)
    end

    it 'should change the in journey status to false' do
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end
    it 'should reduce the balance by the fare' do
      expect { oystercard.touch_out }.to change { oystercard.balance }.by(-Oystercard::MINIMUM_FARE)
    end
    it 'should forget entry station upon touching out' do
      oystercard.touch_out
      expect(oystercard.entry_station).to eq nil
    end
  end

  describe '#in_journey?' do
    it 'should be false before touching in' do
      expect(oystercard).not_to be_in_journey
    end
  end

end
