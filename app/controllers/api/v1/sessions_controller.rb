module Api
	module V1
		class SessionsController < ApplicationController
		    include ActionController::RequestForgeryProtection
			require 'net/http'
  			require 'json'
  			require "base64"

			skip_before_action :verify_authenticity_token
  			after_action :set_csrf_cookie

		    protected

			    def set_csrf_cookie
			      if action_name == "create"
				      if current_user
				        cookies['X-CSRF-Token'] =  Digest::MD5.hexdigest(current_user.encrypted_password)
				      end
			  	  elsif action_name == "destroy"
			  	  	cookies.delete("X-CSRF-Token")
			  	  end
			    end
			
			public

				def create
					  user = User.find_by_email(params['email'].downcase)
					  if user.valid_password?(params['password']) then
					    sign_in(user)
					    user.update_attributes(:is_signed_in => true)
					    render json:
				          {
				            Type: 'Success - signed in successfully.',
				            Firstname: current_user.first_name,
				            Lastname: current_user.last_name,
				            authenticity_token: Digest::MD5.hexdigest(current_user.encrypted_password)
				          }, status: 200
					  else
					    render json:
				          {
				            Type: 'Failure - unable to sign in.' 
				          }, status: 400
					  end
				end


				def destroy
					user = User.find_by_email(params['email'].downcase)
					token = request.headers["token"]

					if user.present? && user.is_signed_in?
						if cookies['X-CSRF-Token'] ==  token
							sign_out(user)
							user.update_attributes(:is_signed_in => nil)
							render json:
					          {
					            Type: 'Success - signed out successfully.' 
					          }, status: 200
						else
							render json:
					          {
					            Type: 'Failure - invalid authenticity token.' 
					          }, status: 400
						end

					else
						render json:
					          {
					            Type: 'Failure - unable to sign out.' 
					          }, status: 400
					end
				end
		end
	end
end