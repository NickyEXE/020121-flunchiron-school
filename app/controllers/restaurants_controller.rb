class RestaurantsController < ApplicationController
  before_action :authorized

  def index
    @restaurants = Restaurant.fetch_by_location(current_user.zip_code)
  end

  def show
    @review = Review.new
    @restaurant = Restaurant.find(params[:id])
  end

end
