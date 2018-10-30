module Api
	module V1
		class BlogController < ApplicationController
			skip_before_action :verify_authenticity_token
			require 'net/http'
  			require 'json'

			def user_blogs
				user = User.find_by_email(params[:author_email])
				token = params[:authenticity_token]

				token_string = user.email+user.encrypted_password
				generated_token = Digest::MD5.hexdigest(token_string)

				if token == generated_token
					if user.present?
						if user.is_signed_in?
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
				            Type: 'Failure - please sign in to continue.' 
				          }, status: 400
					    end	
					else
				    	render json:
				          {
				            Type: 'Failure - No such user exists.' 
				          }, status: 400
			      	end
			    else
			    	render json:
				          {
				            Type: 'Failure - Invalid authenticity token.' 
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