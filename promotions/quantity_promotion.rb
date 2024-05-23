require_relative 'promotion'

class QuantityPromotion < Promotion
  def initialize(item_name, required_quantity, discount_price)
    @item_name = item_name
    @required_quantity = required_quantity
    @discount_price = discount_price
  end

  def apply(items)
    applicable_items = items.select { |item| item.name == @item_name }
    num_of_applicable_items = applicable_items.size
    return 0 if num_of_applicable_items < @required_quantity

    sets_of_applicable_items = num_of_applicable_items / @required_quantity
    discount = sets_of_applicable_items * (applicable_items.first.price * @required_quantity - @discount_price)
    discount
  end
end