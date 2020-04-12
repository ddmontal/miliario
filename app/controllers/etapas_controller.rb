class EtapasController < ApplicationController
  before_action :set_camino
  before_action :set_etapa, only: [:show, :edit, :update, :destroy]
  before_action :set_home_etapa, only: [:edit, :new, :show]

  def index
  end

  def create
    @etapa = Etapa.new(etapa_params)
    @etapa.camino = @camino

    if @etapa.save
      redirect_to @camino
    else
      render 'new'
    end
  end

  def update
    if @etapa.update(etapa_params)
      redirect_to camino_etapa_path(@camino, @etapa)
    else
      redirect_to caminos_path(@camino)
    end
  end

  def new
    @etapa = Etapa.new
  end

  def edit
  end

  def destroy
  end

  def show
    if @etapa
      @etapa_comienzo = Geocoder.search(I18n.transliterate(@etapa.comienzo)).first
      @etapa_fin = Geocoder.search(I18n.transliterate(@etapa.fin)).first
    end
  end

  private

  def set_camino
    @camino = Camino.find_by(id: params[:camino_id])
  end

  def set_etapa
    @etapa = @camino.etapas.find_by(id: params[:id])
    @home_path = camino_path(@etapa.camino) if @etapa
  end

  def set_home_etapa
    @home_path = camino_path(@camino)
  end

  def etapa_params
    params.require(:etapa).permit(:comienzo, :fin, :distancia)
  end
end
