Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  
  #user management through devise
  devise_for :users, :path=>"auth", :controllers=>{:registrations => :users}
  
  resources :users
  resources :grades, only: [:update, :edit, :show]
  resources :students do
    collection do
      post 'bulk_add'
      post 'bulk_remove'
    end
  end
  resources :assignments do
    member do
      get 'edit_grades'
      get 'update_grades'
      post 'save_grades'
    end
  end

  #admin routes
  get 'admin/index' => 'admin#index'
  #report routes
  get 'reports/students' => 'reports#students'
  get 'reports/master' => 'reports#master'
  
  resources :lockers do
    collection do
      get 'checkout'
      post 'bulk_update'
      put 'rotate'
    end
  end
  
  resources :items

end
