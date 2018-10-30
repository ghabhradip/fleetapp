class HomeController < ApplicationController
  def index
    @users = User.all 
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  def blacklist_user
    user = User.find(params[:id])
    user.update_attributes(:is_blacklisted => true)
    
    flash[:notice] = "User blacklisted."
    redirect_to home_index_path
  end

  def activate_user
    user = User.find(params[:id])
    user.update_attributes(:is_blacklisted => nil)
    
    flash[:notice] = "User activated."
    redirect_to home_index_path
  end

  def list_blogs
    @blogs = Blog.all
  end
end
