Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    
  end
  post 'auth/login_admin', to: 'authentication#authenticate_admin'
  post 'signup/admin', to: 'users#create_admin'
end
