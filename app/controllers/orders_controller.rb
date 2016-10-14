class OrdersController < ApplicationController
  def index
    @orders = Order
      .includes(:products, purchases: [:shipments])
      .all
  end

  def create
    @order = Order.create.tap do |order|
      (rand(10)+3).times do
        Purchase.create(
          order: order,
          product: Product.all.sample
        )
      end
    end

    redirect_to orders_path
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to orders_path
  end
end
