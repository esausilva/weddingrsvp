Rails.application.routes.draw do
  root 'rsvps#new'
  resources :rsvps
  devise_for :users, :path => '', :path_names => { :sign_in => 'login', :sign_up => 'signup', :sign_out => 'logout' }
end
