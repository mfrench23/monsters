Rails.application.routes.draw do
  resources :equipment_modifier_categories

  root 'welcome#index'

  # multiple table inheritance: monsters -> creatures and swarms
  resources :monsters, :only => [:index, :show]
  resources :creatures do
    member do
      get 'variant'
    end
  end
  resources :swarms do
    member do
      get 'variant'
    end
  end

  # other resources
  resources :campaigns
  resources :master_traits do
    member do
      get 'merge_into'
      post 'do_merge_into'
    end
  end
  resources :master_skills
  resources :monster_classes
  resources :books
  resources :move_types
  resources :locations

  resources :equipment_categories
  resources :equipment_types do
    collection do
      get :autocomplete_equipment_category_name
      get :mass_entry
      post :do_mass_entry
    end
  end
  resources :equipment_pieces, :except => [:new, :create]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
