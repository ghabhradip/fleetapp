module Api
	module V1
		class BlogController < ApplicationController
			require 'net/http'
  			require 'json'
  			require "base64"

			skip_before_action :verify_authenticity_token
			
			public

				def user_blogs
					user = User.find_by_email(params[:author_email])
					token = request.headers["token"]

					if cookies['X-CSRF-Token'].present?
						if cookies['X-CSRF-Token'] == token
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
				    else
				    	render json:
					          {
					            Type: 'Failure - please sign in to continue.' 
					          }, status: 400
				    end
				end



				def all_blogs
					token = request.headers["token"]
					if cookies['X-CSRF-Token'].present?
						if cookies['X-CSRF-Token'] == token
							user = User.find_by_email(params[:email])
							if user.present?
								if user.is_admin?
									blogs = Blog.all
							    	render json:
							          {
							            Type: 'Success',
							            Blogs: blogs
							          }, status: 200
							    else
							    	render json:
							          {
							            Type: 'Failure - You must need admin access.' 
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
					else
						render json:
					          {
					            Type: 'Failure - please sign in to continue.' 
					          }, status: 400
					end
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