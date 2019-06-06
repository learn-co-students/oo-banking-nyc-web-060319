require_relative "./bank_account.rb"

class Transfer
  COMPLETE = "complete"
  REJECTED = "rejected"
  REVERSED = "reversed"
  # your code here
  attr_accessor :sender, :receiver, :status, :amount
  def initialize(source, destination, amount)
    @sender = source
    @receiver = destination
    @status = BankAccount::PENDING
    @amount = amount
  end

  def valid?
    if @sender.valid? && @receiver.valid?
      return true
    end
    false
  end

  def execute_transaction
    if @status != BankAccount::PENDING
      return
    end
    if @sender.balance >= @amount
      @receiver.deposit(@amount)
      @sender.deposit(-@amount)
      #@amount = 0
      @status = COMPLETE
    else
      @status = REJECTED
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status != COMPLETE
      return
    end
    @receiver.deposit(-@amount)
    @sender.deposit(@amount)
    @status = REVERSED
  end

end
