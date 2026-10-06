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
    service = Orders::CreateService.new(order_params)

    if service.call
      render json: service.order, status: :created
    else
      render json: { errors: service.errors }, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:item_name, :total_amount)
  end
end
