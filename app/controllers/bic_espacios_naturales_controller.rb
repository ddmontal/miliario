class BicEspaciosNaturalesController < ApplicationController
  before_action :set_bic_espacio_natural, only: [:show, :edit, :update, :destroy]
  before_action :set_etapa, only: [:index, :show, :edit, :new, :create, :update]
  before_action :home_devuelve_bics, only: [:show, :new]
  before_action :home_devuelve_bic, only: :edit
  before_action :home_devuelve_etapa, only: :index

  def index
    @bic_espacios_naturales = @etapa.bic_espacios_naturales
  end

  def show
  end

  def create
    @bic_espacio_natural = BicEspacioNatural.new(bic_espacio_natural_params)
    @bic_espacio_natural.etapa = Etapa.find(params[:etapa_id])
    @bic_espacio_natural.coordenadas = localizar_coordenadas(bic_espacio_natural_params[:localizacion])

    if @bic_espacio_natural.save
      redirect_to camino_etapa_bic_espacios_naturales_path(
        @etapa.camino,
        @etapa,
        @bic_espacio_natural
      )
    else
      render 'new'
    end
  end

  def new
    @bic_espacio_natural = BicEspacioNatural.new
  end

  def edit
  end

  def update
    @bic_espacio_natural.coordenadas = localizar_coordenadas(bic_espacio_natural_params[:localizacion])
    if @bic_espacio_natural.update(bic_espacio_natural_params)
      redirect_to [
        @bic_espacio_natural.etapa.camino,
        @bic_espacio_natural.etapa,
        @bic_espacio_natural
      ]
    else
      render 'edit'
    end
  end

  def destroy
    @bic_espacio_natural.destroy

    redirect_to camino_etapa_bic_espacios_naturales_path(
      @bic_espacio_natural.etapa.camino,
      @bic_espacio_natural.etapa,
      nil
    )
  end

  private

  def bic_espacio_natural_params
    params.require(:bic_espacio_natural).permit(
      :nombre, :localizacion, :coordenadas, :historia, :extension,
      :etapa_id, :etapa, :horario, :imagen
    )
  end

  def set_bic_espacio_natural
    @bic_espacio_natural = BicEspacioNatural.find(params[:id])
  end

  def set_etapa
    @etapa = Etapa.find(params[:etapa_id])
  end

  def home_devuelve_bics
    @home_path = camino_etapa_bic_espacios_naturales_path(
      @etapa.camino,
      @etapa,
      @bic_espacio_natural)
  end

  def home_devuelve_bic
    @home_path = camino_etapa_bic_espacios_naturales_path(
      @etapa.camino,
      @etapa,
      @bic_espacio_natural)
  end

  def home_devuelve_etapa
    @home_path = camino_etapa_path(@etapa.camino, @etapa) if @etapa
  end
end
