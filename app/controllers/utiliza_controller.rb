class UtilizaController < ApplicationController
  skip_before_filter :denegar_acceso_usuario
  before_action :set_realiza
  before_action :set_servicio, only: [:new, :create, :show, :edit]
  before_action :set_utiliza, only: [:edit, :show, :update, :destroy]
  before_action :denegar_acceso, if: -> { @utiliza and @utiliza.usuario != current_usuario }
  before_action :set_home_utiliza, only: [:edit, :new, :show]

  def index
    @servicio = nil
    @servicios_utilizados = @realiza.utiliza
    @servicios_sin_utilizar = @servicios_utilizados && @etapa.servicios.where.not(id: @servicios_utilizados.map(&:servicio_id)) || @etapa.servicios
    @servicios_sin_utilizar = @servicios_sin_utilizar.order(:tipo) if @servicios_sin_utilizar
    # @servicios_utilizados = @servicios_utilizados if @servicios_utilizados
    @comienzo = Geocoder.search(I18n.transliterate(@etapa.comienzo)).first
    @fin = Geocoder.search(I18n.transliterate(@etapa.fin)).first
  end

  def show
  end

  def create
    @utiliza = Utiliza.new(utiliza_params)
    @utiliza.usuario = current_usuario
    @utiliza.servicio = @servicio
    @utiliza.realiza = @realiza

    if @utiliza.save
      redirect_to camino_inicia_etapa_realiza_servicio_utiliza_index_path(
        @camino, @etapa, @inicia, @realiza, @servicio
      )
    end
  end

  def new
    @utiliza = Utiliza.new
  end

  def edit
  end

  def update
    if @utiliza.update(utiliza_params)
      redirect_to camino_inicia_etapa_realiza_servicio_utiliza_path(
        @camino, @etapa, @inicia, @realiza, @servicio, @utiliza
      )
    end
  end

  def destroy
    if @utiliza.destroy
      redirect_to camino_inicia_etapa_realiza_utiliza_index_path(
        @camino, @etapa, @inicia, @realiza, 0, @utiliza
      )
    end
  end

  private

  def set_servicio
    @servicio = Servicio.find_by(id: params[:servicio_id])
    @ya_evaluado = false #current_usuario.servicios.exists?(@servicio)
    @opiniones = Utiliza.order(id: :desc)
  end

  def set_realiza
    @servicio = 0
    @realiza = Realiza.find_by(id: params[:realiza_id])
    @inicia = @realiza.inicia
    @etapa = Etapa.find_by(id: params[:etapa_id])
    @camino = Camino.find_by(id: params[:camino_id])
    @home_path = camino_inicia_etapa_realiza_index_path(@camino, @inicia, @etapa, @realiza)
  end

  def set_utiliza
    @utiliza = Utiliza.find_by(id: params[:id])
  end

  def set_home_utiliza
    @home_path = camino_inicia_etapa_realiza_servicio_utiliza_index_path(
      @camino, @inicia, @etapa, @realiza, @servicio, @utiliza
    )
  end

  def utiliza_params
    if @ya_evaluado
      params.require(:utiliza).permit(:fecha, :fecha)
    else
      params.require(:utiliza).permit(:fecha, :fecha, :critica, :nota)
    end
  end
end
