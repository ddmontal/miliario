class IniciaController < ApplicationController
  skip_before_filter :denegar_acceso_usuario
  before_action :set_camino
  before_action :set_inicia, only: [:edit, :update, :destroy, :show]
  before_action :denegar_acceso, if: -> { @inicia and @inicia.usuario != current_usuario }
  before_action :set_home_iniciados, only: [:edit, :new, :show]

  def index
    @camino_seleccionado_veces_iniciado = Usuario.find(current_usuario).inicia.where(camino: @camino)
  end

  def show
  end

  def create
    @inicia = Inicia.new(inicia_params)
    @inicia.camino = @camino
    @inicia.usuario = current_usuario

    if @inicia.save
      redirect_to camino_inicia_etapa_realiza_index_path(@camino, @inicia, 0)
    else
      redirect_to new_camino_inicia_path(@camino)
    end
  end

  def new
    @inicia = Inicia.new
  end

  def edit
  end

  def update
    if @inicia.update(inicia_params)
      redirect_to camino_inicia_etapa_realiza_index_path(@camino, @inicia, 0)
    else
      redirect_to edit_camino_inicia_path(@camino, @inicia)
    end
  end

  def destroy
    if @inicia.destroy
      redirect_to [@camino, @inicia]
    else
      redirect_to new_camino_inicia_path(@camino)
    end
  end

  private

  def inicia_params
    params.require(:inicia).permit(:fecha_inicio, :fecha_fin, :motivo, :modo, :punto_partida)
  end

  def set_inicia
    @inicia = Inicia.find_by(id: params[:id])
    @home_path = camino_inicia_path(@camino, @inicia)
  end

  def set_home_iniciados
    @home_path = camino_inicia_index_path(@camino)
  end

  def set_camino
    @camino = Camino.find_by(id: params[:camino_id])
    @modos_camino = Parametro.find_by(clave: :modos_iniciar_ruta).valor.map{
      |m| [m.humanize, m]
    }

    @home_path = caminos_path

    if @camino
      @camino_comienzo = Geocoder.search(I18n.transliterate(@camino.inicio)).first
      @camino_fin = Geocoder.search(I18n.transliterate(@camino.fin)).first
    end
  end
end
