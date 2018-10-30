class BlogController < ApplicationController
  def index
    @blogs = current_user.blogs
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new
    @blog.title = params[:blog][:title]
    @blog.body = params[:blog][:body]
    @blog.user_id = current_user.id

    if @blog.save
      flash[:notice] = "Blog successfully created."
    else
      flash[:alert] = "Unable to create blog."
    end
    redirect_to blog_index_path
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    @blog.update_attributes(:title => params[:blog][:title], :body => params[:blog][:body])
    @blog.save

    flash[:notice] = "Blog successfully created."
    redirect_to blog_index_path

  end

  def show
    @blog = Blog.find(params[:id])
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    flash[:notice] = "Blog deleted."
    redirect_to blog_index_path
  end
end
