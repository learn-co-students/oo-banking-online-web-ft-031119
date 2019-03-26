require 'pry'
require_relative '../lib/bank_account'
class Transfer
  attr_accessor  :status
  attr_reader :sender, :receiver, :amount
  def initialize(sender,receiver,amount)
    @sender,@receiver = sender,receiver
    @status = "pending"
    @amount = amount
  end
  def valid?
    @sender.valid? && @receiver.valid?
  end
  def execute_transaction
    if @status == "pending" && self.valid?
      if @sender.balance >= @amount
        @sender.balance -= @amount
        @receiver.balance += @amount
        @status = "complete"
      else
        @status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    end
  end
  def reverse_transfer
    if @status == "complete"
      @status = "reversed"
      @sender.balance += @amount
      @receiver.balance -= @amount
    end
  end
end
