class ShowsController < ApplicationController
	before_filter :require_user, :except => :create


	def require_user
		if session[:admin] 
			flash[:error] = "You were trying to view a page you are not authorized to view."
			redirect_to admin_path(session[:user_id])
		end
	end
	def index
		@movies = Movie.all
    	@date = Date.today
    	respond_to do |format|
    		format.html
    		format.js
    	end
    	@movie_shows = []
	end
	def movie_list
		@listing_by_theatre = []
		@listing_by_movie = []
		if(params[:movie] == "select movie")
			@listing_by_theatre = Movie.movie_listing_by_theatre(params[:theatre], params[:movie_date])
		else
			@listing_by_movie = Movie.movie_listing_by_movie(params[:movie], params[:movie_date])
		end
		session[:movie_name] = params[:movie]
		session[:movie_date] = params[:movie_date]
	end

	def create
		jb
		date_to = params[:date_to].to_s
		date_from = params[:date_from].to_s
		show_tim_arr = params[:showtime]
		msg = MovieShow.add_show(params[:theatre], params[:audi], params[:movie], show_tim_arr, date_to, date_from)
		redirect_to admin_path(session[:user_id]), :notice => "#{msg}"
	end
end