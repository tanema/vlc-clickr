class VlcController < ApplicationController

	def index
		methods = params[:method].split('/')
		method = methods.delete_at(0)
		args = params[:arg]
		begin
			unless args
				VLC.send(method)  
			else  
				VLC.send(method, args) 
			end
		rescue Exception => e
			render :json => {:err => e.to_s}
			return
		end
		
		render :json => {:status => "ok"}
	end

end
