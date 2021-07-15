Rails.application.routes.draw do
  get 'steamapps/index'
  root to: "steamapps#index"
end
