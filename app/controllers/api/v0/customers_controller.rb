class Api::V0::CustomersController < ApplicationController

  def show
    if Customer.exists?(params[:id])
      @customer = Customer.find(params[:id])
      render json: SubscriptionSerializer.new(@customer.subscriptions)
    else
      render json: {error: "Customer not found"}, status: 404
    end
  end

  def cancel
    if Customer.exists?(params[:id])
      @customer = Customer.find(params[:id])
      if Subscription.exists?(params[:subscription_id])
        @subscriptions = @customer.subscriptions.find(params[:subscription_id])
        if @subscriptions.status == "active"
          @subscriptions.update(status: "cancelled")
          combined_response = 
          render json: {message: "Subscription is cancelled", subscription: SubscriptionSerializer.new(@subscriptions)}, status: 200
        else
          render json: {error: "Subscription is already cancelled"}, status: 400 and return
        end
      else
        render json: {error: "Subscription not found"}, status: 404
      end
    else
      render json: {error: "Customer not found"}, status: 404
    end
  end
end
