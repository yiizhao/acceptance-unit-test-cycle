require "rails_helper"

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

describe MoviesController do
  describe "given a movie id, find the similar movies," do
    
    context "the movie info has a director" do
      before :each do
        match_movie = double("Movie_1", title: 'Star Wars1', director: 'George Lucas')
        @fake_results = [match_movie, double("Movie_2", title: 'Star Wars2', director: 'George Lucas')]
        expect(Movie).to receive(:find).with("1").and_return(match_movie)
        expect(Movie).to receive(:find_same_director).with(match_movie).
          and_return(@fake_results)
      end
      
      it "should call Movie to match similar movies" do
        get :movies_same_director, id:1
        expect(assigns(:movies)).to match_array(@fake_results)
      end
    end
    
    context "the movie info has no director" do
      before :each do
        @match_movie = double("Movie_1", title: 'Star Wars', director: '')
        expect(Movie).to receive(:find).with("1").and_return(@match_movie)
        get :movies_same_director, id:1
      end
      
      it "should redirect to movies_path and with a warning" do
        expect(flash[:warning]).to eq "'#{@match_movie.title}' has no director info"
        expect(response).to redirect_to(movies_path)
      end
    end
  end
end