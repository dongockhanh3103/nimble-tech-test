Rails.application.routes.draw do
  get 'session/new'
  get 'attachment/index'
  post 'attachment/upload'
  get "/auth/signin", to: "session#new", as: :signin
  get "/auth/signout", to: "session#destroy", as: :signout
  get "/auth/:provider/callback", to: "session#create"
  resources :files, only: [] do
    collection do
      get 'report'
    end
  end

  match "/404", to: "errors#file_not_found", via: :all
  match "/403", to: "errors#unauthorized", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  root 'attachment#index'
end
