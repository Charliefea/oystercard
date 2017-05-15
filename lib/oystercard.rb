class Oystercard
  attr_reader :balance
  BALANCE_LIMIT = 90
  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Your balance cannot exceed £#{BALANCE_LIMIT}" if balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def in_journey?
    @in_journey
  end
end
