Rails.application.routes.draw do
  post "mini_trees/sync", as: :sync
end
