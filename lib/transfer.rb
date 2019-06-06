require_relative "./bank_account.rb"
require_relative "statuses.rb"

class Transfer
  # your code here
  attr_accessor :sender, :receiver, :status, :amount
  def initialize(source, destination, amount)
    @sender = source
    @receiver = destination
    @status = Status::PENDING
    @amount = amount
  end

  def valid?
    if @sender.valid? && @receiver.valid?
      return true
    end
    false
  end

  def execute_transaction
    if @status != Status::PENDING
      return
    end
    if @sender.balance >= @amount
      @receiver.deposit(@amount)
      @sender.deposit(-@amount)
      #@amount = 0
      @status = Status::COMPLETE
    else
      @status = Status::REJECTED
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status != Status::COMPLETE
      return
    end
    @receiver.deposit(-@amount)
    @sender.deposit(@amount)
    @status = Status::REVERSED
  end

end
