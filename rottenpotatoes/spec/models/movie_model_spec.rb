require 'rails_helper'

describe Movie do
    describe ".find_same_director" do
      context "given a movie" do
        it "should call find_same_director functon" do
          match_movie = double("Movie_1", director: 'George Lucas')
          fake_results = [match_movie]
          # check if the function is called later
          expect(Movie).to receive(:where).with("director LIKE ?",'George Lucas').
            and_return(fake_results)
          expect(Movie.find_same_director match_movie).to eq fake_results
        end
        
        it "should return only movies matched" do
          givenMovie = double("Movie_1", director: 'George Lucas')
          movie2 = double("Movie_2", director: 'George Lucas')
          movie3 = double("Movie_3", director: 'George Lucas')
          unMatchedMovie = double("Movie_4", director: 'Jack Olson')
          matchedMovies = [givenMovie, movie2, movie3]
          allow(Movie).to receive(:where).with("director LIKE ?",'George Lucas').
            and_return(matchedMovies)
          expect(Movie.find_same_director givenMovie).to eq(matchedMovies) 
        end
        
        it "should not return movies unmatched" do
          givenMovie = double("Movie_1", director: 'George Lucas')
          movie2 = double("Movie_2", director: 'George Lucas')
          movie3 = double("Movie_3", director: 'George Lucas')
          unMatchedMovie = double("Movie_4", director: 'Jack Olson')
          matchedMovies = [givenMovie, movie2, movie3]
          allow(Movie).to receive(:where).with("director LIKE ?",'George Lucas').
            and_return(matchedMovies)
          expect(Movie.find_same_director(givenMovie)).not_to include(unMatchedMovie)
        end
      end
  end
end