Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'admin/dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # patch "admin/image_infos"=>"admin/image_infos#toggle"
end
