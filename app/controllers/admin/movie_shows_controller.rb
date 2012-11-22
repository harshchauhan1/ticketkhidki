class Admin::MovieShowsController < ApplicationController
	layout 'admin'
	before_filter :require_admin


	def require_admin
		unless session[:admin] 
			redirect_to after_sign_in_path, notice: "You are not authorized"
		end
	end

	def new
		@theatres = Theatre.scoped
	end

	def create
		
		date_to = params[:date_to].to_s
		date_from = params[:date_from].to_s
		show_tim_arr = params[:showtime]
		if Date.parse(date_to) < Date.parse(date_from) 
      		flash[:error] = "invalid date selection"
    	end
    	if (show_tim_arr.uniq.length != show_tim_arr.length)
      		flash[:error] = "select distinct timings"
    	end
		status, movie_show = MovieShow.add_show(params[:theatre], params[:audi], params[:movie], show_tim_arr, date_to, date_from)
		if status
			redirect_to after_sign_in_path, :notice => "show/s added succesfully"
		else
			flash[:error] = movie_show.errors.messages
			redirect_to after_sign_in_path
		end
	end
end