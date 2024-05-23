require_relative '../checkout'
require_relative '../item'
require_relative '../promotions/quantity_promotion'
require_relative '../promotions/total_price_promotion'

describe Checkout do
  describe '#total_price' do
    context 'when there are no promotions' do
      it 'provides a total price for all scanned items' do
        checkout = Checkout.new
        item_a = Item.new('A', 3000)
        item_b = Item.new('B', 2000)

        checkout.scan(item_a)
        checkout.scan(item_b)

        expect(checkout.total_price).to eq 5000
      end
    end

    context 'when there is a total price promotion' do
      it 'provides a total for all scanned items minus the total price promotion' do
        checkout = Checkout.new
        promotion = TotalPricePromotion.new(15000, 2000)
        item_c = Item.new('C', 5000)

        checkout.add_promotion(promotion)
        4.times { checkout.scan(item_c) }

        expect(checkout.total_price).to eq 18000
      end
    end

    context 'when there is a quantity promotion' do
      it 'provides a total for all scanned items minus the applicable quantity promotion' do
        checkout = Checkout.new
        promotion = QuantityPromotion.new('A', 3, 7500)
        item_a = Item.new('A', 3000)

        checkout.add_promotion(promotion)
        checkout.scan(item_a)
        checkout.scan(item_a)
        checkout.scan(item_a)

        expect(checkout.total_price).to eq 7500
      end
    end

    context 'when there are multiple promotions' do
      it 'provides a total for all scanned items minus all promotion discounts' do
        checkout = Checkout.new
        quantity_promotion_a = QuantityPromotion.new('A', 3, 7500)
        quantity_promotion_b = QuantityPromotion.new('B', 2, 3500)
        total_price_promotion = TotalPricePromotion.new(15000, 2000)
        item_a = Item.new('A', 3000)
        item_b = Item.new('B', 2000)
        item_c = Item.new('C', 5000)
        item_d = Item.new('D', 1500)

        checkout.add_promotion(quantity_promotion_a)
        checkout.add_promotion(quantity_promotion_b)
        checkout.add_promotion(total_price_promotion)
        checkout.scan(item_c)
        checkout.scan(item_b)
        checkout.scan(item_a)
        checkout.scan(item_a)
        checkout.scan(item_d)
        checkout.scan(item_a)
        checkout.scan(item_b)

        expect(checkout.total_price).to eq 15500
      end
    end
  end
end