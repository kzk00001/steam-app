Rails.application.routes.draw do
  root to: "apps#index"
  resources :apps, only: [:index, :show] do
    collection do
      get 'search'
    end
  end
end
