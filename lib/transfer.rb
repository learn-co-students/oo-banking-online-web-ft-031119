class Transfer
  attr_accessor :sender, :receiver, :status, :amount
  
  def initialize(sender, receiver, amount)
    @sender=sender
    @receiver=receiver
    @amount=amount
    @status="pending"
  end
  
  def valid?
    @sender.valid? && @receiver.valid?
  end
  
  def execute_transaction
    if self.valid? && @status=="pending" && @sender.balance>=@amount
      @status="complete"
      @sender.deposit(-@amount)
      @receiver.deposit(@amount)
    else
      @status="rejected"
      "Transaction rejected. Please check your account balance."
    end
  end
  
  def reverse_transfer
    if @status=="complete"
      @sender.deposit(@amount)
      @receiver.deposit(-@amount)
      @status="reversed"
    end
  end
end
