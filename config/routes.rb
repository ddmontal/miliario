Rails.application.routes.draw do
  root 'home#index'

  get 'home/perfil_usuario'

  mount Attachinary::Engine => "/attachinary"

  devise_for :usuarios, controllers: {
    sessions: 'usuarios/sessions',
    registrations: 'usuarios/registrations'
  }

  resources :parametros

  resources :caminos do
    resources :inicia do
      resources :etapa do
        resources :realiza do
          resources :servicio do
            resources :utiliza
          end
        end
      end
    end

    resources :etapas do
      resources :servicios
      resources :bic_artisticos
      resources :bic_espacios_naturales do
        resources :especies
      end
    end
  end

end
