require 'rails_helper'

RSpec.feature "Visitor navigates to product details", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    1.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99,
        image: open_asset('apparel1.jpg')
      )
      
    end
  end
  scenario "They see product details" do
    # ACT
    visit root_path
    find('article.product img').click

    # DEBUG / VERIFY
    save_screenshot
    expect(page).to have_css 'article.product-detail'
  end
end