class ReviewsController < ApplicationController
  before_filter :has_user

  def create
    review = current_user.reviews.create(review_params)
    if review.save
      redirect_to :back
    else
      render :back
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
