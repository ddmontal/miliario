class RealizaController < ApplicationController
  skip_before_filter :denegar_acceso_usuario
  before_action :set_inicia
  before_action :set_etapa, only: [:new, :create, :show, :edit]
  before_action :set_realiza, only: [:edit, :show, :update]
  before_action :denegar_acceso, if: -> { @realiza and @realiza.usuario != current_usuario }
  before_action :set_home_realiza, only: [:edit, :new, :show]

  def index
  end

  def show
  end

  def create
    @realiza = Realiza.new(realiza_params)
    @realiza.usuario = current_usuario
    @realiza.etapa = @etapa
    @realiza.inicia = @inicia

    if @realiza.save
      redirect_to camino_inicia_etapa_realiza_index_path(@camino, @inicia, 0)
    end
  end

  def new
    @realiza = Realiza.new
  end

  def edit
  end

  def update
    if @realiza.update(realiza_params)
      redirect_to camino_inicia_etapa_realiza_index_path(@camino, @inicia, 0)
    end
  end

  def destroy
    if @realiza.destroy
      redirect_to camino_inicia_etapa_realiza_index_path(@camino, @inicia, 0)
    end
  end

  private

  def set_inicia
    @inicia = Inicia.find_by(id: params[:inicia_id])

    if @inicia
      @etapa = 0
      @camino = @inicia.camino
      @camino_comienzo = Geocoder.search(I18n.transliterate(@camino.inicio)).first
      @camino_fin = Geocoder.search(I18n.transliterate(@camino.fin)).first
      @etapas = @camino.etapas.order(:posicion)

      unless @inicia.realiza.blank?
        @realizadas = @inicia.realiza.order(:etapa_id)
      end

      @etapas_sin_realizar = @realizadas && @etapas.where.not(id: @realizadas.map(&:etapa_id)) || @etapas
      @home_path = camino_inicia_index_path(@camino)
    end

  end

  def set_etapa
    @etapa = Etapa.find_by(id: params[:etapa_id])
  end

  def set_realiza
    @realiza = Realiza.find_by(id: params[:id])
  end


  def set_home_realiza
    @home_path = camino_inicia_etapa_realiza_index_path(@camino, @inicia, @etapa, @realiza)
  end

  def realiza_params
    params.require(:realiza).permit(:fecha_inicio, :fecha_fin)
  end
end
