class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order
      .includes(:products, purchases: [:shipments])
      .find(params[:id])
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

    redirect_to @order
  end
end
