class ReviewsController < ApplicationController
  before_filter :has_user

  def create
    review = current_user.reviews.create(review_params)
    if review.save
      redirect_to :back
    else
      redirect_to product_path(id: params[:product_id])
    end
  end

  def destroy
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
      params.require(:review)
      params.permit(:product_id).merge(params.require(:review).permit(:rating, :description))
    end

    def has_user
      if !current_user
        redirect_to :products
      end
    end

end
