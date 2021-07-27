class Movie < ActiveRecord::Base
  def self.find_same_director(movie)
    Movie.where("director LIKE ?", movie.director)
  end
    
end
