class RestaurantsController < ApplicationController

  def index
    @params = params.permit(:location).to_h
    @restaurants = Restaurant.fetch_by_location(params[:location] || current_user.zip_code).kind_of_food(params[:kind_of_food])
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @review = Review.find_or_initialize_by(user: current_user, restaurant: @restaurant)
  end

end
