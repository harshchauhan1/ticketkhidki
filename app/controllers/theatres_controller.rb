class TheatresController < ApplicationController

	def create
		
		msg = Theatre.add_new(params[:audis], params[:theatre_location])
		redirect_to admin_path(session[:user_id]), :notice => msg
	end

	def audis 
		@audis = Theatre.find(params[:theatre_id]).audis
		respond_to do |format|
			format.json { render json: @audis}
		end
	end

	def destroy 
			msg = Theatre.remove_old(params[:theatre])
			redirect_to admin_path(session[:user_id]), :notice => msg
		
	end
end