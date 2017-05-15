require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }

  it 'has a default balance of 0' do
    expect(oystercard.balance).to eq 0
  end

  describe '#top_up' do
    it 'should be able to be topped up' do
      expect { oystercard.top_up(5) }.to change { oystercard.balance }.from(0).to(5)
    end
    it 'should prevent balance from exceeding £90' do
      expect { oystercard.top_up(91) }.to raise_error {"Your balance cannot exceed £90"}
    end
  end

end
