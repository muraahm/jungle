class Admin::DashboardController < ApplicationController
  def show
    @products_count = Product.all.order(created_at: :desc).count

    @category_count = Category.all.count
  end
end
