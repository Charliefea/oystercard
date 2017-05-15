class Oystercard
  attr_reader :balance
  BALANCE_LIMIT = 90
  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Your balance cannot exceed £#{BALANCE_LIMIT}" if balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

end
