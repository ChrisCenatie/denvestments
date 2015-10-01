class LoanQuantities
  def initialize(order)
    @order = order
  end

  def loan_id_quantities
    Hash[@order.order_items.pluck(:loan_id, :quantity)]
  end

  def loans_and_quantities
    loan_id_quantities.map do |id, quantity|
      [Loan.find(id), quantity]
    end
  end

  def loan_quantities
    Hash[loans_and_quantities]
  end
end
