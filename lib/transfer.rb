require 'pry'
require_relative './bank_account'

class Transfer

  attr_accessor :amount, :sender, :receiver, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    sender.valid? && sender.balance > @amount && receiver.valid?
  end

  def execute_transaction
    if self.status == "pending" && self.valid? == true
      receiver.deposit(amount)
      sender.withdrawal(amount)
      self.status = "complete"
    elsif self.status == "pending" && self.valid? == false
      # binding.pry
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      receiver.withdrawal(amount)
      sender.deposit(amount)
      self.status = "reversed"
    end
  end

end
