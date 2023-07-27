
Subscription.destroy_all
Tea.destroy_all
Customer.destroy_all

@customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith', email: 'joey@joey.com', address: '123 Main St Denver,CO 80218')
@customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones', email: 'cecilia@aol.com', address: '456 1st St Denver,CO 80218')
@customer_3 = Customer.create!(first_name: 'Maria', last_name: 'Simpson', email: 'maria@hotmail.com', address: '789 2nd St Denver,CO 80218')
@customer_4 = Customer.create!(first_name: 'James', last_name: 'Bond', email: 'james@yahoo.com', address: '1011 3rd St Denver,CO 80218')


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

@subscription_1 = Subscription.create!(title: 'Weekly', price: 10.00, status: "active", frequency: "weekly", customer_id: @customer_1.id, tea_id: @tea_1.id)
@subscription_2 = Subscription.create!(title: 'Monthly', price: 30.00, status: "active", frequency: "monthly", customer_id: @customer_1.id, tea_id: @tea_2.id)
@subscription_3 = Subscription.create!(title: 'Bi-Weekly', price: 20.00, status: "active", frequency: "bi-weekly", customer_id: @customer_3.id, tea_id: @tea_3.id)
@subscription_4 = Subscription.create!(title: 'Bi-monthly', price: 40.00, status: "active", frequency: "bi-monthly", customer_id: @customer_4.id, tea_id: @tea_4.id)
@subscription_5 = Subscription.create!(title: 'Monthly', price: 50.00, status: "canceled", frequency: "monthly", customer_id: @customer_1.id, tea_id: @tea_5.id)