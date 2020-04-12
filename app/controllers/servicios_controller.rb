class ServiciosController < ApplicationController
  before_action :set_etapa
  before_action :set_servicio, only: [:show, :edit, :update, :destroy]
  before_action :set_home_servicio, only: [:edit, :new, :show]

  def index
    @servicios = @etapa.servicios.order(:tipo).order(:nombre)
  end

  def create
    @servicio = Servicio.new(servicio_params)
    @servicio.etapa = @etapa

    @servicio.coordenadas = localizar_coordenadas(servicio_params[:localizacion])

    if @servicio.save
      redirect_to camino_etapa_servicio_path(@camino, @etapa, @servicio)
    end
  end

  def update
    @servicio.coordenadas = localizar_coordenadas(servicio_params[:localizacion])

    if @servicio.update(servicio_params)
      redirect_to camino_etapa_servicios_path(@camino, @etapa)
    end
  end

  def new
    @servicio = Servicio.new
  end

  def edit
  end

  def destroy
    if @servicio.destroy
      redirect_to camino_etapa_servicios_path(@camino, @etapa)
    end
  end

  def show
  end

  private

  def set_etapa
    @etapa = Etapa.find_by(id: params[:etapa_id])
    @camino = @etapa.camino if @etapa
    @home_path = camino_etapa_path(@camino, @etapa)
  end

  def set_servicio
    @servicio = Servicio.find_by(id: params[:id])
  end

  def set_home_servicio
    @home_path = camino_etapa_servicios_path(@camino, @etapa)
  end

  def servicio_params
    params.require(:servicio).permit(
      :nombre, :localizacion, :horario, :telefono, :tipo, :disponibilidad
    )
  end

end
