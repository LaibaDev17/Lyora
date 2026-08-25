class CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.includes(:product)
  end

  def create
    product = Product.find(params[:product_id])

    cart_item = CartItem.find_or_initialize_by(product: product)

    if cart_item.new_record?
      cart_item.quantity = 1
    else
      cart_item.quantity += 1
    end

    cart_item.save

    redirect_to cart_items_path
  end

  def update
    cart_item = CartItem.find(params[:id])

    if params[:change] == "increase"
      cart_item.quantity += 1
    elsif params[:change] == "decrease"
      cart_item.quantity -= 1
    end

    if cart_item.quantity <= 0
      cart_item.destroy
    else
      cart_item.save
    end

    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy

    redirect_to cart_items_path
  end
end