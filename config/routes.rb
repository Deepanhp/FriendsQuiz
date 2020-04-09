Rails.application.routes.draw do


  get 'about' => 'pages#about'

  get 'faq' => 'pages#faq'

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'
  
  resources:quizzes

  resources:questions

  resources:options

  resources:categories

  resources:submissions

  get 'signup', to: 'users#new'

  resources:users, except:[:new]
  
  get 'question/edit' => 'quizzes#editQuestion'

  get 'option/edit' => 'quizzes#editOption'

  get 'editPassword' => 'users#editPassword'

  post 'editPassword' => 'users#updatePassword'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
end
