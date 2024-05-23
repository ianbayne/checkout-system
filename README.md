# Checkout System
## Brief Description
This solution was designed with extensibility and maintainability in mind and consists of the following classes:
- `Checkout`: Handles the scanned items and added promotions, and calculates the total price of items minus any promotional discounts.
- `Item`: Consists of name and price attributes and represents a scannable item.
- `Promotion`: An abstract base class for concrete promotions to extend from.
- `QuantityPromotion`: A specific implementation of `Promotion` used to add discounts when a certain number of the same named items have been scanned.
- `TotalPricePromotion`: A specific implementation of `Promotion` used to add discounts when the total price exceeds a minimum defined value.

## Thought Process
The most important consideration was to design a solution where the marketing team could create new types of promotions beyond the already existing quantity and total price-based promotions. To that end, I created a `Promotion` base class with a simple interface and that all new promotions should inherit from. This will help to ensure future promotions can be easily created.

## Usage
This system can be used by creating instances of `Checkout`, `Item`, and `Promotion`, scanning the items and adding the promotions, and then calling the `#total_price` method on the `Checkout` instance to get the total price after all promotional discounts. For example: 

```ruby
checkout = Checkout.new
promotion = TotalPricePromotion.new(3000, 500)
checkout.add_promotion(promotion)
item = Item.new('A', 2000)
checkout.scan(item)
checkout.scan(item)
checkout.total_price # => 3500
```

## Running the Test Suite
After running `bundle install` in your terminal, run `bundle exec rspec` to run the full suite of [RSpec](http://rspec.info/) tests.

## Alternative Solutions and Suggestions for Improvements
1. One alternative solution would be for each promotion to be composed with a checkout instance. This would simplify the logic somewhat as it would not be necessary to manually add each promotion to the checkout. Instead a promotion would add itself upon instantiation. An added benefit of this approach would be that the price of the items would not need to be calculated both in the `Checkout` class and in the `TotalPricePromotion` class as the `TotalPricePromotion` class could make use of a `#subtotal` method on the checkout instance. See below for an example:

    ```ruby
    class Checkout
      # ...
      def subtotal
        @items.sum(&:price)
      end
      # ...
    end

    class TotalPricePromotion
      def initialize(minimum_total, discount, checkout)
        # ...
        @checkout = checkout
        @checkout.add_promotion(self)
      end

      def apply
        @checkout.subtotal > @minimum_total ? @discount : 0
      end
    end
    ```

2. Two minor modifications that could be made would be adding methods to `Checkout` to allow for "unscanning" of scanned items and removing of added promotions.