class Cart
  attr_reader :cart
  def initialize(cart_data)
    cart_data ||= Hash.new(0)
    @cart = cart_data
  end

  def add_item(params)
    loan = Loan.find(params[:loan_id].to_i)
    @cart[loan.id.to_s] ||= 0
    @cart[loan.id.to_s] += 1
  end

  def data
    @cart
  end

  def items
    @cart.map do |key, quantity|
      item = Loan.find(key.to_i)
      CartItem.new(item, quantity)
    end
  end

  def total
    items.map{ |item| item.subtotal }.sum
  end

end
