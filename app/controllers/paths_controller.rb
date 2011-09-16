class PathsController < ApplicationController

	def index
		redirect_to "/v"
	end

	def movies
		Moviefoldr.reload if params[:reload]
		logger.info "hey" if params[:reload]
		@contents = Moviefoldr.contents
		respond_to do |format|
		  format.html	{ render "index" }
		  format.json  	{ render :json => @contents.to_json }
		end
	end
	
	def tv
		@contents = Tvfoldr.contents
		respond_to do |format|
		  format.html	{ render "index" }
		  format.json  	{ render :json => @contents.to_json }
		end
	end
	
	def music
		@contents = Musicfoldr.contents
		respond_to do |format|
		  format.html	{ render "index" }
		  format.json  	{ render :json => @contents.to_json }
		end
	end

end
