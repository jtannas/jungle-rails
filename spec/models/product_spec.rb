require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should succeed when given required parameters' do
      category = Category.find_or_create_by! name: 'Apparel'
      product = category.products.new({
        :name => 'test_product',
        :price_cents => 100,
        :quantity => 1,
        :category_id => category
      })
      product.save!  # cause failure if any errors
      product.destroy
    end

    it 'should fail when missing the name' do
      category = Category.find_or_create_by! name: 'Apparel'
      product = category.products.new({
        :price_cents => 100,
        :quantity => 1,
        :category_id => category
      })
      product.save
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should fail when missing the price_cents' do
      category = Category.find_or_create_by! name: 'Apparel'
      product = category.products.new({
        :name => 'test_product',
        :quantity => 1,
        :category_id => category
      })
      product.save
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should fail when missing the quantity' do
      category = Category.find_or_create_by! name: 'Apparel'
      product = category.products.new({
        :name => 'test_product',
        :price_cents => 100,
        :category_id => category
      })
      product.save
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should fail when missing the category_id' do
      product = Product.new({
        :name => 'test_product',
        :price_cents => 100,
        :quantity => 1
      })
      product.save
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
