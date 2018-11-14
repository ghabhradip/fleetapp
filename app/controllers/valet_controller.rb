class ValetController < ApplicationController
  def index
  end

  def new
    @valet = Valet.new
  end

  def create
    @valet = Valet.new
    @valet.name = params[:valet][:name]
    @valet.address = params[:valet][:address]
    @valet.contact_number = params[:valet][:contact_number]
    @valet.aadhar_number = params[:valet][:aadhar_number]
    @valet.voter_id_number = params[:valet][:voter_id_number]
    @valet.current_latitude = params[:valet][:current_latitude]
    @valet.current_longitude = params[:valet][:current_longitude]

    @valet.available = true

    @valet.save!

    flash[:notice] = "Valet details successfully registered."
    redirect_to blog_index_path
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  def list
    @valets = Valet.all
  end
end
