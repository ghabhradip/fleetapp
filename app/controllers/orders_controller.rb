class OrdersController < ApplicationController
  def index
  end

  def new
    @order = Order.new
    @user_name = current_user.name
    gon.user_name = @user_name
  end

  def create
    @order = Order.new

    @order.user_id = current_user.id

    @order.customer_name = params[:order][:customer_name]
    @order.pickup_address = params[:order][:pickup_address]
    @order.delivery_address = params[:order][:delivery_address]

    @order.pickup_date = Date.strptime(params[:order][:pickup_date], '%m/%d/%Y')
    pickup_time = Tod::TimeOfDay.parse params[:order][:pickup_time]
    @order.pickup_time = pickup_time.to_s
    
    if params[:order][:delivery_date].present? && params[:order][:delivery_time].present?
      @order.delivery_date = Date.strptime(params[:order][:delivery_date], '%m/%d/%Y')
      delivery_time = Tod::TimeOfDay.parse params[:order][:delivery_time]
      @order.delivery_time = delivery_time.to_s
      @order.scheduled_delivery_request = true
    end

    if params[:order][:customer_name] == current_user.name
      @order.for_self = true
    end

    @order.status = "open"

    if params[:pop_radio].present? && params[:pop_radio] == "on"
      @order.payment_method_id = PaymentMethod.find_by_name("pay on pickup").id
    end

    if @order.save
      if params[:order_item_names].length > 0
        count = 0
        params[:order_item_names].each do |order_item_name|
          @order_item = OrderItem.new
          @order_item.name = order_item_name
          @order_item.approximate_weight = params[:order_item_weights][count]
          @order_item.order_id = @order.id
          @order_item.save
          count = count + 1
        end
      end
      flash[:notice] = "Order successfully created."
      redirect_to list_blogs_home_index_path
    else
      flash[:alert] = "Unable to place order."
      redirect_to list_blogs_home_index_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def calculate_cost
    cost_array = []
    weight_array = params[:weight]
    weight_array.each do |weight|
      weight = weight.to_f
      if weight < 1000
        cost = 20
      elsif weight >= 1000 && weight < 5000
        cost = 50
      elsif weight >= 5000
        cost = 100    
      end
      cost_array.push(cost)
    end
    render plain: cost_array
  end


  def history
    @orders = Order.where(:user_id => current_user.id)
  end
end
