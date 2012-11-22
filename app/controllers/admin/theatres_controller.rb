class Admin::TheatresController < ApplicationController
	layout 'admin'


	before_filter :require_admin


	def require_admin
		unless session[:admin] 
			redirect_to after_sign_in_path, notice: "You are not authorized"
		end
	end
	
	def create
		@theatre = Theatre.new(params[:theatre])
		if @theatre.save
			redirect_to admin_theatres_path, :notice => "Theatre successfully added"
		else
			render 'new'
		end
	end

	def new
		@theatre = Theatre.new
	end

	def audis 
		@audis = Theatre.find(params[:theatre_id]).audis
		respond_to do |format|
			format.json { render json: @audis}
		end
	end

	def destroy
		if Theatre.where('id = ?', params[:id]).first.try(:destroy)
			redirect_to request.referrer, :notice => "Theatre deleted successfully"
		else
			redirect_to request.referrer, :notice => "something went wrong, try again"
		end
	end

	def log
		if params[:theatre]
			@theatre = Theatre.find_by_location(params[:theatre])
			date = params[:date_for_revenue].to_date
			@report = Booking.theatre_revenue_report(@theatre, date)
		end
	end

	def index
		@theatres = Theatre.scoped
	end
end