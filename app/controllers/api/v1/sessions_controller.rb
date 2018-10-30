module Api
	module V1
		class SessionsController < ApplicationController
			skip_before_action :verify_authenticity_token
			require 'net/http'
  			require 'json'

			def create
				  user = User.find_by_email(params['email'].downcase)
				  if user.valid_password?(params['password']) then
				    sign_in(user)
				    user.update_attributes(:is_signed_in => true)
				    token_string = user.email+user.encrypted_password
				    token = Digest::MD5.hexdigest(token_string)
				    render json:
			          {
			            Type: 'Success - signed in successfully.',
			            authenticity_token: token
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
				if user.present? && user.is_signed_in?
					sign_out(user)
					user.update_attributes(:is_signed_in => nil)
					render json:
			          {
			            Type: 'Success - signed out successfully.' 
			          }, status: 200
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