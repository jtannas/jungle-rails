class ProductsController < ApplicationController
  # Controller for dealing with the display of Products

  def index
    # Display a list of products
    @products = Product.all.order(created_at: :desc)
  end

  def show
    # Display the details of a product
    @product = Product.find params[:id]
  end

end
