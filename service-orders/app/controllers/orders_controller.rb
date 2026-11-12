class OrdersController < ApplicationController
  def index
    # orders = Order.all
    render json: Order.order(:id)
  end

  def show
    order = Order.find_by(id: params[:id])

    if order
      render json: order
    else
      render json: { error: "Pedido não encontrado" }, status: :not_found
    end
  end

  def create
    service = Orders::CreateService.call(order_params)

    if service.success?
      render json: service.order, status: :created
    else
      render json: { errors: service.errors }, status: :unprocessable_content
    end
  end

  private
    def order_params
      params.require(:order).permit(:item_name, :total_amount)
    end
end
