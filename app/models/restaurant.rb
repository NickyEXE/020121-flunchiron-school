class Restaurant < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  scope :kind_of_food, -> (kind_of_food){ where("kind_of_food LIKE ?", "%#{kind_of_food}%") }

  # Same as scope method above
  # def self.kind_of_food(kind_of_food)
  #   where("kind_of_food LIKE ?", "%#{kind_of_food}%")
  # end


  def self.fetch_by_location(location)
    YelpSearch.new(location).to_restaurants
  end

  def average_review
    reviews.average(:rating).to_i
  end

end
