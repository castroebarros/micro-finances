Rails.application.routes.draw do
  resources :payments do
    get :calculate_interest_and_penalty_values, on: :collection
    get :calculate_payment_value, on: :collection
  end
end
