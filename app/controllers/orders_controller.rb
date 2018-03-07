class OrdersController < ApplicationController
  # Controller for dealing with the Order Model & Views

  def show
    # Display the order to the user
    # Params:
    # +id+::
    @order = Order.find(params[:id])
  end

  def create
    # Delegates creating an order and mails the customer if successful
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      empty_cart!
      OrderMailer.order_confirmation_email(order).deliver_now
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private
    def empty_cart!
      # Set the cart contents to an empty hash
      update_cart({})
    end

    def perform_stripe_charge
      # Make a charge using the Stripe payment service
      # Params:
      # +stripeToken+:: Token provided by the Stripe form during POST
      Stripe::Charge.create(
        source:      params[:stripeToken],
        amount:      cart_total, # in cents
        description: "Khurram Virani's Jungle Order",
        currency:    'cad'
      )
    end

    def create_order(stripe_charge)
      # Create and Save a new Order (if valid)
      # Params:
      # +stripeEmail+: The stripe account email
      order = Order.new(
        email: params[:stripeEmail],
        total_cents: cart_total, # Helper Function
        stripe_charge_id: stripe_charge.id, # returned by stripe
      )
      cart.each do |product_id, details|
        if product = Product.find_by(id: product_id)
          quantity = details['quantity'].to_i
          order.line_items.new(
            product: product,
            quantity: quantity,
            item_price: product.price,
            total_price: product.price * quantity
          )
        end
      end
      order.save!
      order
    end

    def cart_total
      # Returns total in cents not dollars (stripe uses cents as well)
      total = 0
      cart.each do |product_id, details|
        if p = Product.find_by(id: product_id)
          total += p.price_cents * details['quantity'].to_i
        end
      end
      total
    end

end
