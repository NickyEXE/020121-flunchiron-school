class RestaurantsController < ApplicationController

  def index
    @params = params.permit(:location, :kind_of_food, :search, :sort).to_h
    @restaurants = Restaurant.fetch_by_location(params[:location], current_user).filter_by_params(@params)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @review = Review.find_or_initialize_by(user: current_user, restaurant: @restaurant)
  end

end
