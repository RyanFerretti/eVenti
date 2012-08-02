EVenti::Application.routes.draw do

  protocol = Rails.env.development? ? "http" : "https"

  match 'profile/:profile_name' => 'profile#show_user', :profile_name => /[^\/]+/, :as => :show_user_profile, :via => :get
  match 'profile/:member_id/vote/:vote_value' => 'ratings#create', :as => :vote_for, :via => :post

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

  match "/rules" => "home#rules", :as => :rules
  match "/terms" => "home#terms", :as => :terms
  match "/welcome" => "home#welcome", :as => :welcome

  match "/mu-76074217-37c5dcb0-4f514cf6-33bcd2d9", :to => proc {|env| [200, {}, ["42"]] }

  namespace :admins do
    root :to => "admins#index"
    get "locations" => "admins#locations", :as => :locations_report
    get "unsubscribed" => "admins#unsubscribed_members"
  end

  resources :members, :only => [] do
    post "activate", :action => :activate
    post "reject", :action => :reject
    post "refresh", :action => :refresh
    #post "subscribe", :action => :subscribe
  end

  post "members/subscribe" => "members#subscribe"

  resources :locations, :path => "/", :only => [] do
    resources :members, :path => "/", :only => [] do
    # TODO add back when we activate cities
    #resources :members, :path => "/", :only => [:index] do
      #get 'page/:page', :action => :index, :on => :collection
      get 'by_status/:status', :action => :by_status, :on => :collection, :as => :by_status
    end
  end

  resources :members, :path => "/", :only => [:index] do
    get 'page/:page', :action => :index, :on => :collection
  end
  
  root :to => "home#index"
end
