class MoviesController < ApplicationController
	def index
		@movies = Movie.all
	end

	def show
		
		@movie = Movie.find_by_id(params[:id]) # what if this movie not in DB?
  		# BUG: we should check @movie for validity here!

	end
end
