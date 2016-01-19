Rails.application.routes.draw do
  root 'rsvps#new'
  resources :rsvps, only: [:index, :new, :create, :destroy] do
    collection do
      get 'thankyou'
      get 'search'
    end
  end
  devise_for :users,
             :path => '',
             :path_names => { :sign_in => 'login', :sign_up => 'signup', :sign_out => 'logout' }

end
