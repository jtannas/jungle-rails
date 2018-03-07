class Admin::ProductsController < AdminController
  # Controller for administering the available products

  def index
    # Display a list of products
    @products = Product.order(id: :desc).all
  end

  def new
    # Show the new product form
    @product = Product.new
  end

  def create
    # Create & Save a new product (if valid)
    @product = Product.new(product_params)

    if @product.save
      redirect_to [:admin, :products], notice: 'Product created!'
    else
      render :new
    end
  end

  def destroy
    # Delete a product from the database
    @product = Product.find params[:id]
    @product.destroy
    redirect_to [:admin, :products], notice: 'Product deleted!'
  end

  private

  def product_params
    # List of required & permitted product fields
    params.require(:product).permit(
      :name,
      :description,
      :category_id,
      :quantity,
      :image,
      :price
    )
  end

end
