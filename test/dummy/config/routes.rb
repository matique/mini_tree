Rails.application.routes.draw do
  resources :names
  post "five", to: "names#five", as: :five
end
