class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order
      .includes(:products, purchases: [:shipments])
      .find(params[:id])
  end
end
