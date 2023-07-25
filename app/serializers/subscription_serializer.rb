class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :customer_id, :tea_id, :frequency, :title, :price, :status
end
