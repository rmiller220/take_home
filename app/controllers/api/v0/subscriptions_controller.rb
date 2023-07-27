class Api::V0::SubscriptionsController < ApplicationController

  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: 201
    else
      render json: {error: "Something went wrong, no tea for you!"}, status: 400
    end
  end

  private

    def subscription_params
      params.permit(:customer_id, :tea_id, :frequency, :title, :price, :status)
    end
end
