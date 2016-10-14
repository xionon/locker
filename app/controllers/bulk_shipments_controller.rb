class BulkShipmentsController < ApplicationController
  def create
    @order = Order.includes(:purchases).find(params[:order_id])

    if params[:lock]
      Rails.logger.info "create with lock"
      create_with_lock
    else
      Rails.logger.info "create without lock"
      create_without_lock
    end

    redirect_to @order
  end

  private

  def create_with_lock
    @order.with_lock do
      create_without_lock
    end
  end

  def create_without_lock
    @order.purchases.each do |purchase|
      unless purchase.shipments.any?
        purchase.shipments.create!
      end
    end
  end
end
