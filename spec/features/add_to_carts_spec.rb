require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Clicking 'Add to Cart shows a change in the cart count" do
    # ACT
    visit root_path
    cart_link = find(".navbar a[href='#{cart_path}']")
    expect(cart_link).to have_content("My Cart (0)")
    within('.products .product:last-child') { click_link('Add') }

    # DEBUG / VERIFY
    cart_link = find(".navbar a[href='#{cart_path}']")
    expect(cart_link).to have_content("My Cart (1)")
  end
end
