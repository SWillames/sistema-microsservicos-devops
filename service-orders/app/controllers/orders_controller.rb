class OrdersController < ApplicationController
  
  def index
    orders = Order.all
    render json: orders.to_json
  end

  
  def show
    order = Order.find_by(id: params[:id])

    if order
      render json: order, status: :ok
    else
      render json: { error: "Pedido não encontrado" }, status: :not_found
    end
  end

  
  def create
    order = Order.new(order_params)

    if order.save
      render json: order, status: :created
    else
   
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:item_name, :total_amount)
  end
end