require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    # validation tests/examples here
      it "product can't be added whithout a name" do
        @category = Category.new(name: "something")
        @product = Product.new(name: nil, price: 3, quantity: 9, category: @category)
        expect(@category).to be_valid
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages.first).to eq "Name can't be blank"
      end
      
      it "product should have price" do
        @category = Category.new(name: "something")
        @product = Product.new(name: "something", price: nil, quantity: 9, category: @category)
        expect(@category).to be_valid
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages.first).to eq 'Price cents is not a number'
      end
      
      it "product should have quantity" do
        @category = Category.new(name: "something")
        @product = Product.new(name: "something", price: 3, quantity: 3, category: @category)
        expect(@category).to be_valid
        expect(@product).to be_valid
      end
      
      it "product should have category" do
        @category = Category.new(name: "something")
        @product = Product.new(name: "something", price: 3, quantity: 3, category: nil)
        expect(@category).to be_valid
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages.first).to eq "Category can't be blank"
      end
  end
end