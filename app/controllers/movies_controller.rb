class MoviesController < ApplicationController
	def index
		@movies = Movie.all
	end

	def show
		id = params[:id] # retrieve movie ID from URL routh
		@movie = Movie.find(id) # look up movie by unique ID
		# will render app/views/movies/show.html.haml by defult
	end
end
