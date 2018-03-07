class CartsController < ApplicationController
  # Cart Model Controller

  def show
    # Displays the Shopping Cart Page
  end

  def add_item
    # Adds an item to a cart then returns to the original page
    # Params:
    # +product_id+:: The product to add one of to the cart
    product_id = params[:product_id].to_s

    item = cart[product_id] || { "quantity" => 0 }
    item["quantity"] += 1
    cart[product_id] = item
    update_cart cart

    redirect_to :back
  end

  def remove_item
    # Removes 1 of an item to a cart then returns to the original page
    # Params:
    # +product_id+:: The product to remove one of to the cart
    product_id = params[:product_id].to_s

    item = cart[product_id] || { "quantity" => 1 }
    item["quantity"] -= 1
    cart[product_id] = item
    cart.delete(product_id) if item["quantity"] < 1
    update_cart cart

    redirect_to :back
  end

end
