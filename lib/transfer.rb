require "pry"

class Transfer
  attr_accessor :status
  attr_reader :sender, :receiver, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if valid? && self.status == "pending"
      sender.balance -= @amount
      receiver.balance += @amount
      self.status = "complete"
    end
    if !sender.valid?
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if valid? && @receiver.balance > @amount && self.status == "complete"
      receiver.balance -= @amount
      sender.balance += @amount
      self.status = "reversed"
    # else
    #   reject_transfer
    end
  end

  # def reject_transfer
  #   self.status = "rejected"
  #   "Transaction rejected. Please check your account balance."
  # end

end
