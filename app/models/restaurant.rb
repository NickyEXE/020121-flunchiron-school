class Restaurant < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  scope :kind_of_food, -> (kind_of_food){ where("kind_of_food LIKE ?", "%#{kind_of_food}%") }
  scope :by_name, -> (name) { where("name LIKE ?", "%#{name}%") }
  scope :by_average_rating, -> {
    joins(:reviews)
    .select("restaurants.id, avg(reviews.rating) as average_rating, count(reviews.id) as number_of_reviews" )
    .group("reviews.id")
    .order("average_rating DESC, number_of_reviews DESC")
  }

  def self.fetch_by_location(location, params)
    YelpSearch.new(location, params).to_restaurants
  end

  def self.filter_by_params(params)
    self.by_name(params[:name]).kind_of_food(params[:kind_of_food])
  end

end
