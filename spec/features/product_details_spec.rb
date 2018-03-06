require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature do
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

  scenario "They navigate from the homepage to product details via the details button" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    within('.products .product:last-child') { click_on 'Details »' }
    expect(current_url).to eq(product_url(:id => 1))
  end

  # Note: Capybara cannot effectively click on html links (eg. headings, images, etc...) so
  # those aren't tested.
end
