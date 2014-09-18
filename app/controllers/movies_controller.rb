class MoviesController < ApplicationController
	def index
		@movies = Movie.all
	end

	def show
		
		@movie = Movie.find_by_id(params[:id]) # what if this movie not in DB?
  		# BUG: we should check @movie for validity here!

	end
	def new
		#default: render 'new' template
	end
	def create
		@movie = Movie.create!(params[:movies])
		flash[:notice] = "#{@movie.title} was successfully created."
		redirect_to movies_path
	end
end
