class OrderMailerPreview < ActionMailer::Preview
  def order_confirmation_email
    OrderMailer.order_confirmation_email(Order.first)
  end
end
