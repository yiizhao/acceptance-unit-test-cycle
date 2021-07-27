Rottenpotatoes::Application.routes.draw do
  get '/movies/movies_same_director/:id', to: 'movies#movies_same_director'
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
