class CategoriesController < ApplicationController
  # Controller for user interactions with the Categories model

  def show
    # Show the products for a given category
    # Params:
    # +id+:: The category id
    @category = Category.find(params[:id])
    @products = @category.products.order(created_at: :desc)
  end

end
