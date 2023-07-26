require 'rails_helper'

RSpec.describe 'Customer subscriptions API' do
  describe 'GET /api/v0/customers/:id/subscriptions' do
    before do
      @customer_1 = Customer.create!(id: 1, first_name: 'Joey', last_name: 'Smith', email: 'joey@joey.com', address: '123 Main St Denver,CO 80218')
      @tea_1 = Tea.create!(title: 'Green', description: 'Green Tea', temperature: "210", brew_time: "4-6 minutes")
      @tea_2 = Tea.create!(title: 'Black', description: 'Black Tea', temperature: "210", brew_time: "5-7 minutes")
      @tea_3 = Tea.create!(title: 'Matcha', description: 'Matcha Tea', temperature: "180", brew_time: "10-15 minutes")
      @subscription_1 = Subscription.create!(title: 'Weekly', price: 10.00, status: "active", frequency: "weekly", customer_id: @customer_1.id, tea_id: @tea_1.id)
      @subscription_2 = Subscription.create!(title: 'Monthly', price: 30.00, status: "active", frequency: "monthly", customer_id: @customer_1.id, tea_id: @tea_2.id)
      @subscription_3 = Subscription.create!(title: 'Monthly', price: 50.00, status: "canceled", frequency: "monthly", customer_id: @customer_1.id, tea_id: @tea_3.id)
    end
    it 'returns all customer subscriptions' do
      get '/api/v0/subscriptions', params: { id: @customer_1.id }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      customer_subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(customer_subscriptions).to be_a(Hash)
      expect(customer_subscriptions).to have_key(:data)
      expect(customer_subscriptions[:data]).to be_a(Array)
      expect(customer_subscriptions[:data].count).to eq(3)

      customer_subscriptions[:data].each do |subscription|

        expect(subscription).to have_key(:id)
        expect(subscription[:id]).to be_a(String)
        expect(subscription).to have_key(:type)
        expect(subscription[:type]).to be_a(String)
        expect(subscription).to have_key(:attributes)
        expect(subscription[:attributes]).to be_a(Hash)
        expect(subscription[:attributes]).to have_key(:customer_id)
        expect(subscription[:attributes][:customer_id]).to be_a(Integer)
        expect(subscription[:attributes]).to have_key(:tea_id)
        expect(subscription[:attributes][:tea_id]).to be_a(Integer)
        expect(subscription[:attributes]).to have_key(:frequency)
        expect(subscription[:attributes][:frequency]).to be_a(String)
        expect(subscription[:attributes]).to have_key(:title)
        expect(subscription[:attributes][:title]).to be_a(String)
        expect(subscription[:attributes]).to have_key(:price)
        expect(subscription[:attributes][:price]).to be_a(String)
        expect(subscription[:attributes]).to have_key(:status)
        expect(subscription[:attributes][:status]).to be_a(String)
      end
    end

    it 'returns an error if customer_id is missing' do
      get '/api/v0/subscriptions', params: { id: 2 }

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      message = JSON.parse(response.body, symbolize_names: true)
      expect(message).to be_a(Hash)
      expect(message).to have_key(:error)
      expect(message[:error]).to eq("Customer not found")
    end
  end
end