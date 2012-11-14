class TheatresController < ApplicationController

	def create
		
		success = Theatre.add_new(params[:audis], params[:theatre_location])
		if success
			redirect_to admin_path(session[:user_id]), :notice => "Theatre #{params[:theatre_location]} has been added successfully"
		else
			redirect_to admin_path(session[:user_id]), :notice => "something went wrong, make sure you enter correct info."
		end
	end

	def audis 
		@audis = Theatre.find(params[:theatre_id]).audis
		respond_to do |format|
			format.json { render json: @audis}
		end
	end

	def destroy 
		
		if params[:theatre] == "select"
			flash[:error] = "Please select a theatre"
			redirect_to admin_path(session[:user_id])
		else
			
			success = Theatre.remove_old(params[:theatre])
			if success
				redirect_to admin_path(session[:user_id]), :notice => "Theatre #{params[:theatre]} has been successfully deleted"
			else
				redirect_to admin_path(session[:user_id]), :notice => "something went wrong, try deleting the theatre again"
			end
		end
	end
end