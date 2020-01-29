Rails.application.routes.draw do
	# 変更箇所3
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
  root 'home#top'
  # 変更箇所1
  get 'home/about' => 'home#about'
end