class Admin::CategoriesController < AdminController
  # Controller for administering the available categories

  def index
    # List the available categories
    @categories = Category.order(id: :asc).all
  end

  def new
    # Show the new category form
    @category = Category.new
  end

  def create
    # Create and save a new category (if valid)
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  private
    def category_params
      # List of required and permitted category fields
      params.require(:category).permit(
        :name
      )
    end

end
