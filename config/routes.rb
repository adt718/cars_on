Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}


#顧客側ルート
  scope module: :customer do
    get "/" => "homes#top"
    get 'about' => "homes#about"
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete 'destroy_all'
    end

      end
      resources :customers, only: [:show, :edit, :update] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
        get "my_page" => "customers#show"
      end
    end
    resources :products, only: [:index, :show]
    resources :addresses, except: [:new, :show]
     resources :orders, only: [:new, :index, :create, :show] do
      collection do
        post '/confirm' => 'orders#confirm'
        get 'complete'
      end
    end
  end


  #管理者側ルート
  namespace :admin do
    resources :products, except: [:destroy]
    resources :genres, except: [:new, :show, :destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
  end
end
