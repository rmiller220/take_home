require 'rails_helper'

RSpec.describe Tea, type: :model do 
  describe 'relationships' do
    it { should have_many(:subscription_teas) }
  end
end