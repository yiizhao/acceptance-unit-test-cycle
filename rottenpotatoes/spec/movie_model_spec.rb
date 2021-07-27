require 'rails_helper'

describe Movie do
    describe ".find_same_director" do
      context "given a movie" do
#         it "should return only movies matched" do
#           givenMovie1 = double("Movie_1", director: 'George Lucas')
#           givenMovie2 = double("Movie_2", director: 'George Lucas')
#           givenMovie3 = double("Movie_3", director: 'George Lucas')
#           expect(Movie.find_same_director(givenMovie1)).to include(givenMovie1)
#           expect(Movie.find_same_director(givenMovie1)).to include(givenMovie2)
#           expect(Movie.find_same_director(givenMovie1)).to include(givenMovie3)
#         end 
        
        it "should not return movies unmatched" do
          givenMovie = double("Movie_1", director: 'George Lucas')
          unMatchedMovie = double("Movie_4", director: 'Jack Olson')
          allMovies = [givenMovie,
                           double("Movie_2", director: 'George Lucas'),
                           double("Movie_3", director: 'George Lucas'), unMatchedMovie]
          expect(Movie.find_same_director(givenMovie)).not_to include(unMatchedMovie)
        end
      end
  end
end