Rails.application.routes.draw do
  get 'session/new'
  get '/auth/signin', to: 'sessions#new', as: :signin
  get '/auth/signout', to: 'sessions#destroy', as: :signout
  get '/auth/:provider/callback', to: 'session#create'
  resources :files, only: [] do
    collection do
      get 'report'
    end
  end

  # Errors
  match '/404', to: 'errors#file_not_found', via: :all
  match '/403', to: 'errors#unauthorized', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  # Report
  get '/reports', to: 'attachments#generate_report'

  # Attachment
  get 'attachments/index'
  post 'attachments/upload'
  root 'attachments#index'
end
