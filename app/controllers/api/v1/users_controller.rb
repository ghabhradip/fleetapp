module Api
	module V1
		class UsersController < ApplicationController
			require 'net/http'
  			require 'json'
  			require "base64"

			skip_before_action :verify_authenticity_token

			def details
				user = User.find_by_email(params[:email])
				if user.present?
					if user.is_admin?
						role = "Admin"
					else
						role = "Normal user"
					end

					if user.is_blacklisted?
						status = "Blacklisted"
					else
						status = "Active"
					end

					render json:
			          {
			            Type: 'Success',
			            Firstname: user.first_name,
			            Lastname: user.last_name,
			            email: user.email,
			            Role: role,
			            Status: status
			          }, status: 200	
				else
			    	render json:
			          {
			            Type: 'Failure - No such user exists.' 
			          }, status: 400
		      	end
			end

			def all_users
				users = User.all
				render json:
		          {
		            Type: 'Success',
		            Blogs: users
		          }, status: 200
			end
		end
	end
end