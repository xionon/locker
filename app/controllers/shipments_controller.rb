class ShipmentsController < ApplicationController
  def create
    purchase = Purchase.find(params[:purchase_id])
    purchase.shipments.create unless purchase.shipments.any?

    redirect_to purchase.order
  end
end
