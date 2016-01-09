Rails.application.routes.draw do
  root 'rsvps#new'
  resources :rsvps
end
