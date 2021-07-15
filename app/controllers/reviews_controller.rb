class ReviewsController < ApplicationController
  before_action :set_restaurant
  before_action :set_review, only: [:update]

  def create
    @review = current_user.reviews.build(review_params)
    @review.restaurant = @restaurant
    if @review.save
      redirect_to @restaurant
    else
      render :"restaurants/show"
    end
  end

  def update
    if @review.update(review_params)
      redirect_to @restaurant
    else
      render :"restaurants/show"
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id]) if params[:restaurant_id]
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end

end
