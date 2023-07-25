require 'rails_helper'

RSpec.describe 'Add a customer subscription API' do
  before(:each) do
    test_data
  end
  describe 'POST /api/v0/subscribe' do
    it 'creates a new subscription for a customer' do
      require 'pry'; binding.pry
      post '/api/v0/subscribe', params: 
    end
  end
end