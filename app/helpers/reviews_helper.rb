module ReviewsHelper

  def stars(int)
    int > 0 ? "⭐️" * int : "No reviews yet!"
  end

end
