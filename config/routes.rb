Rails.application.routes.draw do
  root to: 'companies#index'

  resources :companies do
    scope module: :companies do
      resources :departments
      resources :employees
      resources :forms do
        scope module: :forms do
          resource :preview, only: [:show, :create] do
            scope module: :previews do
              resources :groups, only: [:index, :show] do
                collection do
                  post ':id', action: 'create'
                end
              end
            end
          end
          resources :groups do
            scope module: :groups do
              resources :fields
            end
          end
        end
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
