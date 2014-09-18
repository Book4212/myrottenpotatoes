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
		@movie = Movie.create!(params[:movie])
		flash[:notice] = "#{@movie.title} was successfully created."
		redirect_to movies_path
	end
	def edit
		@movie = Movie.find params[:id]
	end
	
	def update
		@movie = Movie.find params[:id]
		@movie.update_attributes!(params[:movie])
		respond_to do |client_wants|
			client_wants.html { redirect_to movie_path(@movie)}
			client_wants.xml {render :xml => @movie.to_xml}
		end
	end
	def destroy
		@movie = Movie.find params[:id]
		@movie.destroy
		flash[:notice] = "Movie '#{@movie.title}' deleted."
		redirect_to movies_path
	end
end
