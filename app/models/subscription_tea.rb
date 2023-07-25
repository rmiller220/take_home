class SubscriptionTea < ApplicationRecord
  belongs_to :subscription
  belongs_to :teas
end
