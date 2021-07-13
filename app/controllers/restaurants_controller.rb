class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.fetch_by_location(current_user.zip_code)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

end
