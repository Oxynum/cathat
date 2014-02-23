class ApiController < ApplicationController

	def get
		path = params[:path].split('/').last
		@json_doc = File.read("public/api/v0/#{path}.json")
		render json: @json_doc	
	end
end
