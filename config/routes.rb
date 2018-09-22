Rails.application.routes.draw do
  resources :shops do
    resources :products
    resources :orders do
      resources :line_items
    end
  end
end
