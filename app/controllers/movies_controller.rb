class MoviesController < ApplicationController
	def index
		@movies = Movie.all
	end

	def show
		
		@movie = Movie.find_by_id(params[:id]) # what if this movie not in DB?
  		# BUG: we should check @movie for validity here!

	end
	def new
		@movie = Movie.new
	end
	def create
		@movie = Movie.new(params[:movie])
		if @movie.save
			flash[:notice] = "#{@movie.title} was successfully created."
			redirect_to movies_path
		else
			render 'new'
		end
	end
	def edit
		@movie = Movie.find params[:id]
	end
	
	def update
		@movie = Movie.find params[:id]
		if @movie.update_attributes( params[:movie])
			flash[:notice] = "#{@movie.title} was successfully updated."
			redirect_to movie_path(@movie)
		else
			render 'edit'
		end
	end
	def destroy
		@movie = Movie.find params[:id]
		@movie.destroy
		flash[:notice] = "Movie '#{@movie.title}' deleted."
		redirect_to movies_path
	end
	def movies_with_good_reviews
		@movies = Movie.joins(:reviews).group(:movie_id).
			having('AVG(reviews.potatoes) > 3')
	end
	def movies_for_kids
		@movies = Movie.where('rating in ?', %w(G PG))
	end
	def movies_with_filters
		@movies = Movie.with_good_reviews(params[:threshold])
		@movies = @movies.for_kids          if params[:for_kids]
		@movies = @movies.with_many_fans    if params[:with_many_fans]
		@movies = @movies.recently_reviewed if params[:recently_reviewed]
	end
	# or even DRYer:
	def movies_with_filters_2
		@movies = Movie.with_good_reviews(params[:threshold])
		%w(for_kids with_many_fans recently_reviewed).each do |filter|
			@movies = @movies.send(filter) if params[filter]
		end
	end
end
