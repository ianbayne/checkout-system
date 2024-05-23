require_relative 'promotion'

class TotalPricePromotion < Promotion
  def initialize(minimum_total, discount)
    @minimum_total = minimum_total
    @discount = discount
  end

  def apply(items)
    total = items.sum(&:price)
    total > @minimum_total ? @discount : 0
  end
end