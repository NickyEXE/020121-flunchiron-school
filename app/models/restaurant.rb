class Restaurant < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  scope :kind_of_food, -> (kind_of_food){ where("kind_of_food LIKE ?", "%#{kind_of_food}%") }
  scope :search, -> (name){where("name LIKE ?", "%#{name}%")}
  scope :alphabetical, -> {order("lower(name)")}
  scope :by_number_of_reviews, -> {
    left_joins(:reviews)
    .select("restaurants.*, count(reviews.id) AS reviews_count")
    .group("restaurants.id")
    .order("reviews_count DESC")
  }
  scope :average_review, -> {
    left_joins(:reviews)
    .select("restaurants.*, avg(reviews.rating) AS average_review")
    .group("restaurants.id")
    .order("average_review DESC")
  }
  scope :recommended, -> {
    left_joins(:reviews)
    .select("restaurants.*, avg(reviews.rating) AS average_review, count(reviews.id) AS reviews_count")
    .group("restaurants.id")
    .order("average_review DESC, reviews_count DESC")
  }
  scope :filter_by_params, ->(params){
    search(params[:search])
    .kind_of_food(params[:kind_of_food])
    .select_sort(params[:sort])
  }

  # Same as scope method above
  # def self.kind_of_food(kind_of_food)
  #   where("kind_of_food LIKE ?", "%#{kind_of_food}%")
  # end

  # left join the restaurant and reviews tables
  # select count of reviews
  # group by restaurant.id
  # order by the count of reviews

  def self.select_sort(sort)
    case sort
    when "alphabetical"
      alphabetical
    when "number_reviews"
      by_number_of_reviews
    when "average_review"
      average_review
    when "recommended"
      recommended
    else
      all
    end
  end


  def self.fetch_by_location(location, user)
    if !location || location.empty?
      YelpSearch.new(user.zip_code).to_restaurants
    else
      YelpSearch.new(location).to_restaurants
    end
  end

  def average_review
    reviews.average(:rating).to_i
  end

end
