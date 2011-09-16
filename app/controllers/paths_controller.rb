class PathsController < ApplicationController

	def index
		redirect_to "/v"
	end

	def movies
		@contents = Moviefoldr.contents
		render "index"
	end
	
	def tv
		@contents = Tvfoldr.contents
		render "index"
	end
	
	def music
		@contents = Musicfoldr.contents
		render "index"
	end

end
