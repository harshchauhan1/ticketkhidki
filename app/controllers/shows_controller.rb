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
		@location = Movie.movie_details(params[:movie])
		session[:movie] = params[:movie]
		session[:movie_date] = params[:movie_date]	
	end

	def create
	 
		success = MovieShow.add_show(params[:theatre], params[:audi], params[:movie], params[:showtime], params[:date])
		if success
			redirect_to admin_path(session[:user_id]), :notice => "show added succesfully"
		end
	end
end