class ReviewsController < ApplicationController
  # Controller for handling the creation/destruction of reviews

  before_filter :ensure_user  # Only logged in users can modify reviews

  def create
    # Creates a new review & sends them back to their updated page
    review = current_user.reviews.create(review_params)
    if review.save
      redirect_to :back
    else
      redirect_to product_path(id: params[:product_id])
    end
  end

  def destroy
    # Deletes a review and sends them back to their updated page
    review = Review.find(params[:id])
    if review.user_id == current_user.id
      review.destroy
      redirect_to :back
    else
      redirect_to product_path(id: params[:product_id])
    end
  end

  private
    def review_params
      # List of required / permitted review parameters
      params.require(:review)
      params.permit(:product_id).merge(params.require(:review).permit(:rating, :description))
    end

    def ensure_user
      # Helper function to ensure that the user is logged in
      if !current_user
        redirect_to :products
      end
    end

end
