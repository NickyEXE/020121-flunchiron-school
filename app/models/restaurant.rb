class Restaurant < ApplicationRecord

  def self.fetch_by_location(location)
    YelpSearch.new(location).to_restaurants
  end
end
