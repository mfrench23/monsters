Rails.application.routes.draw do
  resources :rpm_spell_effects, :only => [:index]

  get 'rpm_ritual_modifiers/:id' => "rpm_ritual_modifiers#levels", :format => :json
  get 'rpm_ritual_modifier_subtypes/:id' => "rpm_ritual_modifiers#subtypes", :format => :json
  get 'standard_rpm' => "rpm_rituals#standard_rpm"

  resources :rpm_modifiers

  resources :rpm_rituals do
    collection do
      get 'grid'
      get 'full_book', :defaults => { :format => 'pdf' }
    end
  end

  resources :rpm_potencies

  resources :rpm_paths

  resources :rpm_effects

  resources :equipment_modifier_supercategories

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
  resources :campaigns do
    collection do
      get 'randomize'
    end
  end

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

  resources :equipment_categories do
    member do
      get 'randomize'
      get 'merge_into'
      post 'do_merge_into'
    end
  end

  resources :equipment_types do
    collection do
      get :autocomplete_equipment_category_name
      get :mass_entry
      post :do_mass_entry
    end
  end
  resources :equipment_pieces, :except => [:new, :create]

  resources :equipment_modifiers, :except => [:new, :create]

  resources :equipment_packages

  resources :equipment_modifier_categories

  get "/fetch_equipment_modifiers" => 'equipment_pieces#modifiers_for_piece', as: 'fetch_equipment_modifiers'
  get "/set_selected_campaign" => 'campaigns#set_selected_campaign'

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
