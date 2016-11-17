class BulkShipmentsController < ApplicationController
  module OrderFinder
    def self.order_by_id(id, &block)
      order = Order.includes(:purchases).find(id)
      order.with_lock do
        yield order
      end
      order.freeze
      return order
    end
  end

  def create
    if params[:lock]
      Rails.logger.info "create with lock"
      create_with_lock
    else
      Rails.logger.info "create without lock"
      create_without_lock
    end

    redirect_to orders_path
  end

  private

  def create_with_lock
    Rails.logger.tagged "locked" do
      OrderFinder.order_by_id(params[:id]) do |order|
        create_without_lock
      end
    end
  end

  def create_without_lock
    order = Order.find(params[:id])
    order.purchases.each do |purchase|
      unless purchase.shipments.any?
        purchase.shipments.create!
      end
    end
  end
end
