class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates_presence_of :customer_id, :tea_id, :frequency, :title, :price, :status
end
