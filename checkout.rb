class Checkout
  def initialize
    @items = []
  end

  def scan(item)
    @items << item
  end

  def total_price
    @items.sum(&:price)
  end
end