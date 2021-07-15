class Restaurant < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews

  def self.fetch_by_location(location)
    YelpSearch.new(location).to_restaurants
  end
end
