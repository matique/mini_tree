Rails.application.routes.draw do
  resources :names
  post "five" => "names#five", as: :five
end
