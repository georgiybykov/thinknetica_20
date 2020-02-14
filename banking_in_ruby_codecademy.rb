class Account
  attr_reader :name, :balance

  def initialize(name, balance = 100)
    @name = name
    @balance = balance
  end

  def display_balance(pin_number)
    if pin_number == pin
      puts "Balance: $#{@balance}."
    else
      puts pin_error
    end
  end

  def withdrew(pin_number, amount)
    if pin_number == pin
      @balance -= amount
      puts "Withdrew #{amount}. New balance: $#{@balance}."
    else
      puts pin_error
    end
  end

  def deposit(pin_number, amount)
    if pin_number == pin
      @balance += amount
      puts "Withdrew #{amount}. New balance: $#{@balance}."
    else
      puts pin_error
    end
  end

  private

  def pin
    @pin = 1234
  end

  def pin_error
    puts "Access denied: incorrect PIN."
  end
end

checking_account = Account.new('John', 1_000_000)
checking_account.display_balance(1234)
checking_account.withdrew(12, 500_000)
checking_account.withdrew(1234, 500_000)
checking_account.deposit(1234, 25_000)
checking_account.pin
