class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.fetch_by_location(current_user.zip_code)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @review = Review.find_or_initialize_by(user: current_user, restaurant: @restaurant)
  end

end
