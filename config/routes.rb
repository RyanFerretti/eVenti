EVenti::Application.routes.draw do

  protocol = Rails.env.development? ? "http" : "https"

  resources :ads

  resources :locations

  #root :to => "home#index"

#  match 'profile' => 'profile#show', :as => :show_profile, :via => :get
#  match 'profile/edit' => 'profile#edit', :as => :edit_profile, :via => :get
#  match 'profile' => 'profile#update', :as => :update_profile, :via => :put

#  match 'profile/:profile_name' => 'profile#show_user', :profile_name => /[^\/]+/, :as => :show_user_profile, :via => :get

 # match 'profile/:member_id/vote/:vote_value' => 'ratings#create', :as => :vote_for, :via => :post

  constraints :protocol => protocol do
    devise_for :members, :controllers => { :registrations => "members/registrations" }do
      match "members/registrations/:profile_name/success" => "members/registrations#success", :via => :get, :as => :registration_success
    end
  end

  devise_for :clients
  devise_for :admins



  match "members/unique/email" => "profile#verify_unique_email", :as => :unique_email
  match "members/unique/profile_name" => "profile#verify_unique_profile_name", :as => :unique_profile_name

  match "captcha/verify" => "captcha#verify", :as => :verify_captcha
#  resources :events

  match "/rules" => "home#rules"
  match "/terms" => "home#terms"

  match "/mu-76074217-37c5dcb0-4f514cf6-33bcd2d9", :to => proc {|env| [200, {}, ["42"]] }

  match "/" => "home#index", :as => :filter_home, :via => :post

  root :to => "home#index"
end
