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
		date_to = params[:date_to].to_s
		date_from = params[:date_from].to_s
		show_tim_arr = [params[:showtime1], params[:showtime2], params[:showtime3], params[:showtime4]]
		msg = MovieShow.add_show(params[:theatre], params[:audi], params[:movie], show_tim_arr, date_to, date_from)
		redirect_to admin_path(session[:user_id]), :notice => "#{msg}"
	end
end