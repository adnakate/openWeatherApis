Rails.application.routes.draw do
  namespace :api do
    resources :air_pollution_records do 
      get :average_quality_index_per_month_per_location, on: :collection
      get :average_quality_index_per_location, on: :collection
      get :average_quality_index_per_state, on: :collection 
    end
  end
end
