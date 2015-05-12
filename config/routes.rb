WowApp::Application.routes.draw do


  get 'welcome/index'
  devise_for :users, :controllers => {:sessions => 'sessions'}
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get 'package/version/index' => 'wow/package_version#index', :as => :wow_package_version
  get 'package/version/upload' => 'wow/package_version#new', :as => :wow_package_version_upload
  post 'package/version/upload' => 'wow/package_version#create'
  root 'welcome#index'

  namespace :api do
    scope path: :v1, module: :v1 do
      resources :packages, except: [:new, :edit]
      resources :tags, except: [:new, :edit]

      scope module: :packages do
        resources :platforms, except: [:new, :edit]
      end
    end
  end

end
