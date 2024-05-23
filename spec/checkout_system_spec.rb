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
  end
end