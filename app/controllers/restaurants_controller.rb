class RestaurantsController < ApplicationController
  before_action :authorized

  def index
    @location = params[:location] || current_user.zip_code
    @params = params.permit(:location, :kind_of_food, :name).to_hash
    @restaurants = Restaurant.fetch_by_location(@location, @params).filter_by_params(params)
  end

  def show
    @review = Review.new
    @restaurant = Restaurant.find(params[:id])
  end

end
