class Checkout
  def initialize
    @items = []
    @promotions = []
  end

  def scan(item)
    @items << item
  end

  def add_promotion(promotion)
    @promotions << promotion
  end

  def total_price
    subtotal = @items.sum(&:price)
    discount = @promotions.sum { |promotion| promotion.apply(@items) }
    total = subtotal - discount
    total
  end
end