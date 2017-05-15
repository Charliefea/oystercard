class Oystercard
  attr_reader :balance, :entry_station
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1
  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
  end

  def top_up(amount)
    raise "Your balance cannot exceed £#{BALANCE_LIMIT}" if balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if balance < MINIMUM_FARE
    @entry_station = station
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
