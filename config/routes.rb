Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"
  #dont use Vocab, use vocab
   root 'vocabs#index'

   resources :vocabs

   get 'quiz', to: 'quizzes#quiz'
   get 'start_quiz', to: 'quizzes#reset_quiz'
   get 'answer', to: 'quizzes#answer'
   get 'result', to: 'quizzes#result'



   resources :users do
     #collection is when there is no user involved
     collection do
       get "signup", to: "users#new"
       post "signup", to: 'users#create' #or can also change to just post "create" and omit , to: xxx if name is same as controller action
     end
     member do
       #member is when there are users involved
       post '/scores', to: 'users#scores'
       get '/scores', to: 'users#scores'
     end
   end

   get '/login', to: 'sessions#new'
   post '/login', to: 'sessions#create'
   delete '/logout', to: 'sessions#destroy'
   get 'sessions/new'



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
