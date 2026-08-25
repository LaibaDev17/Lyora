class OrdersController < ApplicationController
  def create
    cart_items = CartItem.includes(:product)

    total = 0

    cart_items.each do |item|
      total += item.product.price * item.quantity
    end

    order = Order.create(
      total: total,
      status: "placed"
    )

    cart_items.each do |item|
      order.order_items.create(
        product: item.product,
        quantity: item.quantity,
        price: item.product.price
      )
    end

    cart_items.destroy_all

    redirect_to order_path(order)
  end

  def show
    @order = Order.find(params[:id])
  end
end
