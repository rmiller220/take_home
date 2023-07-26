require 'rails_helper'

RSpec.describe 'Add a customer subscription API' do
  describe 'POST /api/v0/subscribe' do
    before do
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith', email: 'joey@joey.com', address: '123 Main St Denver,CO 80218')
      @tea_1 = Tea.create!(title: 'Green', description: 'Green Tea', temperature: "210", brew_time: "4-6 minutes")
      @tea_2 = Tea.create!(title: 'Black', description: 'Black Tea', temperature: "210", brew_time: "5-7 minutes")
      @tea_3 = Tea.create!(title: 'Oolong', description: 'Oolong Tea', temperature: "200", brew_time: "5-7 minutes")
      @tea_4 = Tea.create!(title: 'White', description: 'White Tea', temperature: "200", brew_time: "8-12 minutes")
      @tea_5 = Tea.create!(title: 'Herbal', description: 'Herbal Tea', temperature: "190", brew_time: "5-7 minutes")
      @tea_6 = Tea.create!(title: 'Chai', description: 'Chai Tea', temperature: "190", brew_time: "4-6 minutes")
      @tea_7 = Tea.create!(title: 'Matcha', description: 'Matcha Tea', temperature: "180", brew_time: "10-15 minutes")
      @tea_8 = Tea.create!(title: 'Rooibos', description: 'Rooibos Tea', temperature: "180", brew_time: "5-10 minutes")
      @tea_9 = Tea.create!(title: 'SleepyTime', description: 'Sleepy Tea', temperature: "200", brew_time: "5-10 minutes")
      @tea_10 = Tea.create!(title: 'ThroatCoat', description: 'Throat Soothing Tea', temperature: "250", brew_time: "5-10 minutes")

    end
    it 'creates a new subscription for a customer' do
      post '/api/v0/subscribe', params: { customer_id: @customer_1.id, tea_id: @tea_1.id, frequency: 'weekly', title: 'Green', price: '10.00', status: 'active' }
      
      expect(response).to be_successful
      expect(response.status).to eq(201)
      
      subscription_data = JSON.parse(response.body, symbolize_names: true)

      expect(subscription_data).to be_a(Hash)
      expect(subscription_data).to have_key(:data)
      expect(subscription_data[:data]).to be_a(Hash)
      expect(subscription_data[:data]).to have_key(:id)
      expect(subscription_data[:data][:id]).to be_a(String)
      expect(subscription_data[:data]).to have_key(:type)
      expect(subscription_data[:data][:type]).to be_a(String)
      expect(subscription_data[:data]).to have_key(:attributes)
      expect(subscription_data[:data][:attributes]).to be_a(Hash)
      expect(subscription_data[:data][:attributes]).to have_key(:customer_id)
      expect(subscription_data[:data][:attributes][:customer_id]).to be_a(Integer)
      expect(subscription_data[:data][:attributes]).to have_key(:tea_id)
      expect(subscription_data[:data][:attributes][:tea_id]).to be_a(Integer)
      expect(subscription_data[:data][:attributes]).to have_key(:frequency)
      expect(subscription_data[:data][:attributes][:frequency]).to be_a(String)
      expect(subscription_data[:data][:attributes]).to have_key(:title)
      expect(subscription_data[:data][:attributes][:title]).to be_a(String)
      expect(subscription_data[:data][:attributes]).to have_key(:price)
      expect(subscription_data[:data][:attributes][:price]).to be_a(String)
      expect(subscription_data[:data][:attributes]).to have_key(:status)
      expect(subscription_data[:data][:attributes][:status]).to be_a(String)
    end

    it 'returns an error if customer_id is missing' do
      post '/api/v0/subscribe', params: { tea_id: @tea_1.id, frequency: 'weekly', title: 'Green', price: '10.00', status: 'active' }

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      message = JSON.parse(response.body, symbolize_names: true)
      expect(message).to be_a(Hash)
      expect(message).to have_key(:error)
      expect(message[:error]).to eq("Something went wrong, no tea for you!")
    end

    it 'returns an error if tea_id is missing' do
      post '/api/v0/subscribe', params: { customer_id: @customer_1.id, frequency: 'weekly', title: 'Green', price: '10.00', status: 'active' }

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      message = JSON.parse(response.body, symbolize_names: true)
      expect(message).to be_a(Hash)
      expect(message).to have_key(:error)
      expect(message[:error]).to eq("Something went wrong, no tea for you!")
    end
    
    it 'returns an error if frequency is missing' do
      post '/api/v0/subscribe', params: { customer_id: @customer_1.id, tea_id: @tea_1.id, frequency: '', title: 'Green', price: '10.00', status: 'active' }

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      message = JSON.parse(response.body, symbolize_names: true)
      expect(message).to be_a(Hash)
      expect(message).to have_key(:error)
      expect(message[:error]).to eq("Something went wrong, no tea for you!")
    end
    
    it 'returns an error if title is missing' do
      post '/api/v0/subscribe', params: { customer_id: @customer_1.id, tea_id: @tea_1.id, frequency: 'weekly', title: '', price: '10.00', status: 'active' }

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      message = JSON.parse(response.body, symbolize_names: true)
      expect(message).to be_a(Hash)
      expect(message).to have_key(:error)
      expect(message[:error]).to eq("Something went wrong, no tea for you!")
    end
    
    it 'returns an error if price is missing' do
      post '/api/v0/subscribe', params: { customer_id: @customer_1.id, tea_id: @tea_1.id, frequency: 'weekly', title: 'Green', price: '' , status: 'active' }
      
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      message = JSON.parse(response.body, symbolize_names: true)
      expect(message).to be_a(Hash)
      expect(message).to have_key(:error)
      expect(message[:error]).to eq("Something went wrong, no tea for you!")
    end
    
    it 'returns an error if status is missing' do
      post '/api/v0/subscribe', params: { customer_id: @customer_1.id, tea_id: @tea_1.id, frequency: 'weekly', title: 'Green', price: '10.00', status: '' }
      
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      message = JSON.parse(response.body, symbolize_names: true)
      expect(message).to be_a(Hash)
      expect(message).to have_key(:error)
      expect(message[:error]).to eq("Something went wrong, no tea for you!")
    end
  end
end