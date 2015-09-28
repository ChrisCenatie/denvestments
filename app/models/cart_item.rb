class CartItem < SimpleDelegator
  attr_reader :loan, :quantity

  def initialize(item, quantity)
    if quantity < 0
      quantity = 0
    end

    @loan = item
    @quantity = quantity
  end

  def subtotal
    @loan.price * @quantity
  end
end
