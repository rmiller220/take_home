require 'rails_helper'

RSpec.describe 'Delete a customer subscription API' do
  describe 'DELETE /api/v0/unsubscribe' do
    before do
      @customer_1 = Customer.create!(id: 1, first_name: 'Joey', last_name: 'Smith', email: 'joey@joey.com', address: '123 Main St Denver,CO 80218')
      @tea_1 = Tea.create!(title: 'Green', description: 'Green Tea', temperature: "210", brew_time: "4-6 minutes")
      @tea_2 = Tea.create!(title: 'Black', description: 'Black Tea', temperature: "210", brew_time: "5-7 minutes")
      @tea_3 = Tea.create!(title: 'Matcha', description: 'Matcha Tea', temperature: "180", brew_time: "10-15 minutes")
      @subscription_1 = Subscription.create!(id: 1, title: 'Weekly', price: 10.00, status: "active", frequency: "weekly", customer_id: @customer_1.id, tea_id: @tea_1.id)
      @subscription_2 = Subscription.create!(id: 2, title: 'Monthly', price: 30.00, status: "active", frequency: "monthly", customer_id: @customer_1.id, tea_id: @tea_2.id)
      @subscription_3 = Subscription.create!(id: 3, title: 'Monthly', price: 50.00, status: "canceled", frequency: "monthly", customer_id: @customer_1.id, tea_id: @tea_3.id)
    end
    it 'deletes a customer subscription' do
      delete '/api/v0/unsubscribe', params: { id: 1, subscription_id: @subscription_1.id }

      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      confirmation_message = JSON.parse(response.body, symbolize_names: true)

      expect(confirmation_message).to be_a(Hash)
      expect(confirmation_message).to have_key(:message)
      expect(confirmation_message[:message]).to eq("Subscription is cancelled")
    end

    it 'returns an error if customer_id is missing' do
      delete '/api/v0/unsubscribe', params: { id: 2, subscription_id: @subscription_1.id }

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      message = JSON.parse(response.body, symbolize_names: true)

      expect(message).to be_a(Hash)
      expect(message).to have_key(:error)
      expect(message[:error]).to eq("Customer not found")
    end

    it 'returns an error if subscription_id is invalid' do
      delete '/api/v0/unsubscribe', params: { id: 1, subscription_id: 4 }

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      
      message = JSON.parse(response.body, symbolize_names: true)

      expect(message).to be_a(Hash)
      expect(message).to have_key(:error)
      expect(message[:error]).to eq("Subscription not found")
    end

    it 'returns an error if subscription id is missing' do
      delete '/api/v0/unsubscribe', params: { id: 1 }

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      
      message = JSON.parse(response.body, symbolize_names: true)

      expect(message).to be_a(Hash)
      expect(message).to have_key(:error)
      expect(message[:error]).to eq("Subscription not found")
    end

    it 'returns an error if subscription is already cancelled' do
      delete '/api/v0/unsubscribe', params: { id: 1, subscription_id: @subscription_3.id }

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      message = JSON.parse(response.body, symbolize_names: true)

      expect(message).to be_a(Hash)
      expect(message).to have_key(:error)
      expect(message[:error]).to eq("Subscription is already cancelled")
    end
  end
end