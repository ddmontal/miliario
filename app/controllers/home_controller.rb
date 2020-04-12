class HomeController < ApplicationController
  skip_before_filter :denegar_acceso_usuario
  skip_before_filter :authenticate_usuario!, except: :perfil_usuario
  before_action :get_nombre_controlador
  # layout "home_layout"

  def index
    # @nombre_accion = I18n.t('index')
  end


  def perfil_usuario
    @home_path = caminos_path
    @resource ||= current_usuario
    @caminos = current_usuario.caminos.distinct
    @camino = Camino.last
    @etapas = current_usuario.etapas
  end

  private

  def get_nombre_controlador
    # @nombre_controlador = I18n.t('index')
  end

end
