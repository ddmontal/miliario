class ParametrosController < ApplicationController
  before_action :denegar_acceso, unless: -> { current_usuario.admin? && current_usuario.alias == 'admin' }
  before_action :set_parametro, only: [:show, :edit, :update, :destroy]
  before_action :set_home, only: [:show, :edit, :new]

  # GET /parametros
  # GET /parametros.json
  def index
    @parametros = Parametro.all
    @home_path = caminos_path
  end

  # GET /parametros/1
  # GET /parametros/1.json
  def show
  end

  # GET /parametros/new
  def new
    @parametro = Parametro.new
  end

  # GET /parametros/1/edit
  def edit
  end

  # POST /parametros
  # POST /parametros.json
  def create
    @parametro = Parametro.new()
    @parametro.clave = parametro_params[:clave]
    @parametro.multi = parametro_params[:multi]

    if @parametro.multi
      @parametro.valor = obtener_valores
    else
      @parametro.valor = parametro_params[:valor]
    end

    respond_to do |format|
      if @parametro.save
        format.html { redirect_to @parametro, notice: 'Parametro was successfully created.' }
        format.json { render :show, status: :created, location: @parametro }
      else
        format.html { render :new }
        format.json { render json: @parametro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parametros/1
  # PATCH/PUT /parametros/1.json
  def update
    respond_to do |format|
      @parametro.clave = parametro_params[:clave]

      if @parametro.multi
        @parametro.valor = obtener_valores
      else
        @parametro.valor = parametro_params[:valor]
      end

      if @parametro.save()
        format.html { redirect_to @parametro, notice: 'Parametro was successfully updated.' }
        format.json { render :show, status: :ok, location: @parametro }
      else
        format.html { render :edit }
        format.json { render json: @parametro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parametros/1
  # DELETE /parametros/1.json
  def destroy
    @parametro.destroy
    respond_to do |format|
      format.html { redirect_to parametros_url, notice: 'Parametro was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parametro
      @parametro = Parametro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parametro_params
      params.require(:parametro).tap do |whitelisted|
        whitelisted[:clave] = params[:parametro][:clave]
        whitelisted[:valor] = params[:parametro][:valor]
        whitelisted[:bloqueado] = params[:parametro][:bloqueado]

        for i in 0..params[:parametro].count do
          whitelisted["valor#{i}".to_sym] = params[:parametro]["valor#{i}".to_sym]
        end
      end
      # params.require(:parametro).permit(:clave, :valor)
    end

    def obtener_valores
      valores = []
      for i in 0..params[:parametro].count do
        v = params[:parametro]["valor#{i}"]
        unless v.blank?
          valores.append(v.downcase)
          params[:parametro]["valor#{i}"].remove
        end
      end
      return valores
    end

    def set_home
      @home_path = parametros_path
    end
end
