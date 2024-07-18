# app/mailers/order_mailer.rb
class OrderMailer < ApplicationMailer
  default from: ENV["MAILGUN_FROM_EMAIL"]

  def order_confirmation(order)
    @order = order
    mail(to: @order.user.email, subject: "Order Confirmation")
  rescue StandardError => e
    Rails.logger.error "Failed to send order confirmation email: #{e.message}"
    raise e
  end
end
