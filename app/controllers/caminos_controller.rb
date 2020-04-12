class CaminosController < ApplicationController
  skip_before_filter :denegar_acceso_usuario, only: :index
  before_action :set_camino, only: [:show, :edit, :update, :destroy]
  before_action :set_home_camino, only: [:edit, :new, :show]

  def index
    @caminos = Camino.all
  end

  def show
    @etapas = @camino.etapas.all
    @home_path = caminos_path
  end

  def create
    @camino = Camino.new(post_params)
    if @camino.save
      redirect_to @camino
    else
      render 'new'
    end
  end

  def new
    @camino = Camino.new
  end

  def destroy
    @camino.destroy
    redirect_to caminos_path
  end

  def edit
  end

  def update
    redirect_to @camino if @camino.update(post_params)
  end

  private

  def set_camino
    @camino = Camino.find_by(:id => params[:id])
  end

  def set_home_camino
    @home_path = caminos_path
  end

  def post_params
    params.require(:camino).permit(:nombre, :inicio, :fin)
  end
end
