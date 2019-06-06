class Transfer

attr_accessor :sender, :receiver, :amount, :status

def initialize(sender, receiver, amount)
  @sender = sender
  @receiver = receiver
  @amount = amount
  @status = "pending"
end

def valid?
  enoughMoney = @sender.balance >= @amount
  validStatus = @sender.valid? && @receiver.valid?
  return enoughMoney && validStatus
end

def execute_transaction
    #puts @sender.valid?
  if valid? && @status == "pending"
    @sender.balance = @sender.balance - @amount
    #puts @sender.balance
    @receiver.balance = @receiver.balance + @amount
    #puts @receiver.balance
    @status = "complete"
  else
    @status = "rejected"
    "Transaction rejected. Please check your account balance."
  end

end

def reverse_transfer
 if @status == "complete"
   @sender.balance += @amount
   @receiver.balance -= @amount
   @status = "reversed"
 end
end



end
