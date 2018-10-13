Refinery::Core::Engine.routes.draw do
  # Frontend routes
  namespace :inquiries do

    resources :inquiries, :path => '', :only => [:index, :new, :create] do
      collection do
        get :thank_you
      end
    end
  end

  # Admin routes
  namespace :inquiries, :path => '' do
    namespace :admin, :path => "#{Refinery::Core.backend_route}" do
      resources :inquiries do 
  end

      scope :path => 'inquiries' do
        resources :settings, :only => [:edit, :update]
      end
    end
  end
end

