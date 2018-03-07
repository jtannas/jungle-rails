require 'rails_helper'

RSpec.describe Order, type: :model do

  describe 'before creation' do
    before :each do
      @cat1 = Category.find_or_create_by! name: 'Apparel'

      # Setup at least two products with different quantities, names, etc
      @product1 = @cat1.products.create!({
        name:  'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      })
    end

    it "does not deduct quantity from products when there isn't enough product" do
      # 1. initialize order with necessary fields
      @order = Order.new(
        email: 'test@inter.net',
        total_cents: 0,
        stripe_charge_id: 123456
      )
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: @product1.quantity + 1,
        item_price: @product1.price,
        total_price: @product1.price * (@product1.quantity + 1)
      )
      # 3. save the order expecting a false for no-op
     expect(@order.save).to be_falsey
    end
  end

  describe 'After creation' do
    before :each do
      @cat1 = Category.find_or_create_by! name: 'Apparel'

      # Setup at least two products with different quantities, names, etc
      @product1 = @cat1.products.create!({
        name:  'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      })

      @product2 = @cat1.products.create!({
        name:  'Women\'s Zebra pants',
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel2.jpg'),
        quantity: 18,
        price: 124.99
      })
      # Setup at least one product that will NOT be in the order
      @product3 = @cat1.products.create!({
        name:  'Hipster Hat',
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel3.jpg'),
        quantity: 4,
        price: 34.49
      })
    end

    it 'deducts quantity from products based on their line item quantities' do
      # 1. initialize order with necessary fields
      @order = Order.new(
        email: 'test@inter.net',
        total_cents: 0,
        stripe_charge_id: 123456
      )
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 1,
        item_price: @product1.price,
        total_price: @product1.price * 1
      )
      @order.line_items.new(
        product: @product2,
        quantity: 2,
        item_price: @product2.price,
        total_price: @product2.price * 2
      )
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eq(10 - 1)
      expect(@product2.quantity).to eq(18 - 2)
    end

    it 'does not deduct quantity from products that are not in the order' do
      # 1. initialize order with necessary fields
      @order = Order.new(
        email: 'test@inter.net',
        total_cents: 0,
        stripe_charge_id: 123456
      )
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 1,
        item_price: @product1.price,
        total_price: @product1.price * 1
      )
      @order.line_items.new(
        product: @product2,
        quantity: 2,
        item_price: @product2.price,
        total_price: @product2.price * 2
      )
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product3.reload
      # 5. use RSpec expect syntax to assert no change to unrelated products
      expect(@product3.quantity).to eq(4 - 0)
    end
  end

end
