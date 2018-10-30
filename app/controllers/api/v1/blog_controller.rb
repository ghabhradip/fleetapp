module Api
	module V1
		class BlogController < ApplicationController
			skip_before_action :verify_authenticity_token
			require 'net/http'
  			require 'json'

			def user_blogs
				user = User.find_by_email(params[:author_email])
				if user.present?
					associated_blogs = user.blogs
					
					render json:
			          {
			            Type: 'Success',
			            Author: user.email,
			            Blogs: associated_blogs
			          }, status: 200	
				else
			    	render json:
			          {
			            Type: 'Failure - No such user exists.' 
			          }, status: 400
		      	end
			end

			def all_blogs
				blogs = Blog.all
		    	render json:
		          {
		            Type: 'Success',
		            Blogs: blogs
		          }, status: 200
			end

			def get_blog
				blog = Blog.find_by_title(params[:title])
				if blog.present?
					render json:
			          {
			            Type: 'Success',
			            Blog: blog
			          }, status: 200
				else
					render json:
			          {
			            Type: 'Failure - No such blog exists.' 
			          }, status: 400
				end
			end
		end
	end
end