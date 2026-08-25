class CheckoutController < ApplicationController
  def index
    @cart_items = CartItem.includes(:product)
  end
end
