class BicArtisticosController < ApplicationController
  before_action :set_bic_artistico, only: [:show, :edit, :update, :destroy]
  before_action :set_etapa, only: [:index, :show, :edit, :new, :create, :update]
  before_action :home_devuelve_bics, only: [:show, :new]
  before_action :home_devuelve_bic, only: [:edit]
  before_action :home_devuelve_etapa, only: [:index]

  def index
    @bic_artisticos = @etapa.bic_artistico.all
  end

  def show
  end

  def create
    @bic_artistico = BicArtistico.new(bic_artistico_params)
    @bic_artistico.etapa = Etapa.find(params[:etapa_id])
    @bic_artistico.coordenadas = localizar_coordenadas(bic_artistico_params[:localizacion])

    if @bic_artistico.save
      if craftar_obtener_imagen(@bic_artistico)
        redirect_to [@etapa.camino, @etapa, @bic_artistico]
      else
        render 'new'
      end

    else
      render 'new'
    end
  end

  def new
    @bic_artistico = BicArtistico.new
  end

  def edit
  end

  def update
    @bic_artistico.coordenadas = localizar_coordenadas(bic_artistico_params[:localizacion])
    if @bic_artistico.update(bic_artistico_params)
      if craftar_obtener_imagen(@bic_artistico)
        redirect_to [
          @bic_artistico.etapa.camino,
          @bic_artistico.etapa,
          @bic_artistico
        ]
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  def destroy
    @bic_artistico.destroy
    craftar_obtener_imagen(@bic_artistico).destroy

    redirect_to camino_etapa_bic_artisticos_path(
      @bic_artistico.etapa.camino,
      @bic_artistico.etapa,
      nil
    )
  end

  private

  def bic_artistico_params
    params.require(:bic_artistico).permit(
      :nombre, :localizacion, :coordenadas, :historia, :tipo,
      :estilo, :etapa_id, :etapa, :horario, :imagen
    )
  end

  def set_bic_artistico
    @bic_artistico = BicArtistico.find(params[:id])
  end

  def set_etapa
    @etapa = Etapa.find(params[:etapa_id])
  end

  def home_devuelve_bics
    etapa = Etapa.find(params[:etapa_id])
    @home_path = camino_etapa_bic_artisticos_path(
      etapa.camino,
      etapa,
      @bic_artistico)
  end

  def home_devuelve_bic
    etapa = Etapa.find(params[:etapa_id])
    @home_path = camino_etapa_bic_artistico_path(
      etapa.camino,
      etapa,
      @bic_artistico)
  end

  def home_devuelve_etapa
    @home_path = camino_etapa_path(@etapa.camino, @etapa) if @etapa
  end
end
