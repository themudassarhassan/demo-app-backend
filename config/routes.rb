Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    # routes for products
    get 'products', to: 'products#index'
    get 'products/:id', to: 'products#show'
    put 'products/:id', to: 'products#update'
    delete 'products/:id', to: 'products#destroy'
    post 'products', to: 'products#create'
    get 'my-products', to: 'products#my_products'

    # routes for auth
    post 'login', to: 'users#login'
    post 'signup', to: 'users#signup'

    # routes for user
    put 'users', to: 'users#update'
    put 'update-password', to: 'users#update_password'

    # routes for comments
    post 'products/:product_id/comments', to: 'comments#create'
    put 'products/:product_id/comments/:comment_id', to: 'comments#update'
    delete 'products/:product_id/comments/:comment_id', to: 'comments#destroy'

    # route for catagories
    get 'catagories', to: 'catagories#index'

    post 'create-payment-intent', to: 'orders#create_payment_intent'

    post 'verify-email', to: 'users#verify_email'
    post 'reset-password', to: 'users#reset_password'

    # route for coupon

    get 'coupons/:key', to: 'coupons#verify_coupon'
  end
end
