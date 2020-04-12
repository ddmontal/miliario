class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  before_action :authenticate_usuario!
  before_action :denegar_acceso_usuario

  include HttpAcceptLanguage::AutoLocale

  def denegar_acceso_usuario
     if usuario_signed_in?
        denegar_acceso unless current_usuario.admin?
     end
  end

  def redirect_to_back(default = root_url)
    if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back
    else
      redirect_to default
    end
  end

  def localizar_coordenadas(direccion)
    geoposicion = Geocoder.search(I18n.transliterate(direccion)).first
    return "POINT(#{geoposicion.latitude} #{geoposicion.longitude})" if geoposicion.respond_to? :latitude
  end

  def craftar?
    Parametro.find_by(clave: :par_craftar_api_key).blank?
  end

  def craftar_obtener_imagen(bic)
    return true unless craftar?

    if require_craftar
      craftar_item = craftar_obtener_item(bic)

      if cloudinary_imagen = cloudinary_subir_imagen(bic)
        logger.info "---Cloudinary--- Imagen: #{cloudinary_imagen}"

        if craftar_item && defined?(craftar_item.uuid)
            logger.info "---CraftAr item uri---#{craftar_item.resource_uri}"
            logger.info "---Cloudinary imagen url---#{cloudinary_imagen['url']}"

            Craftar::Image.list(item__uuid: craftar_item.uuid)[:objects].each do |i|
              i.destroy
            end

            craftar_image = Craftar::Image.create(
              item: craftar_item.resource_uri,
              file: cloudinary_imagen['url']
            )

            if craftar_image && defined?(:uuid) && !craftar_image.uuid.blank?
              unless bic.update(craftar_image_uuid: craftar_image.uuid)
                craftar_image.destroy
              end
            end
        end
      else
        craftar_item.destroy
      end

      Cloudinary::Uploader.destroy(bic.cloudinary_image_public_id)
    end

    return craftar_image || nil
  end

  def cloudinary_subir_imagen(bic)
    cloudinary_imagen = nil
    logger.info "---Cloudinary--- Empezando subir imagen: #{bic.imagen.path}"
    if File.exists?(bic.imagen.path)
      logger.info "---Cloudinary--- Subiendo imagen: #{bic.imagen.path}"

      cloudinary_imagen = Cloudinary::Uploader.upload(bic.imagen.path)

      if cloudinary_imagen and cloudinary_imagen['public_id']
        logger.info "---Cloudinary--- Imagen Public Id: #{cloudinary_imagen['public_id']}"
        logger.info "---Cloudinary--- Imagen url: #{cloudinary_imagen['url']}"
        unless bic.update(cloudinary_image_public_id: cloudinary_imagen['public_id'])
          Cloudinary::Uploader.destroy(cloudinary_imagen['public_id'])
        end
      end
    else
      logger.info   "---Cloudinary--- El archivo no existe"
    end

    return cloudinary_imagen
  end

  def denegar_acceso
    render status: :unauthorized, inline: %{
      <h1>
        <%= t('acceso_denegado') %>
      </h1>
    }
  end

  private

  def require_craftar
    require 'craftar'
    Craftar.api_key = Parametro.find_by(clave: :par_craftar_api_key).valor
  end

  def craftar_obtener_coleccion
    if require_craftar
      par_craftar_coleccion = Parametro.find_by(clave: :par_craftar_collection)
      logger.info  "---CraftAR--- Parametro UUID: #{par_craftar_coleccion.valor} ---"
      craftar_coleccion = Craftar::Collection.find(par_craftar_coleccion.valor)

      unless defined?(craftar_coleccion.uuid) && craftar_coleccion.uuid
        craftar_coleccion = Craftar::Collection.create(name: "miliario${#{SecureRandom.uuid}}")
        logger.info  "---CraftAR--- UUID Coleccion: #{craftar_coleccion.uuid} ---"

        if par_craftar_coleccion.update(valor: craftar_coleccion.uuid)
          logger.info  "---CraftAR--- Nombre Coleccion: #{craftar_coleccion.name} ---"
          token = Craftar::Token.list(collection__uuid: craftar_coleccion.uuid)[:objects].first.token
          Parametro.create(clave: :par_craftar_coleccion_name, valor: craftar_coleccion.name)
          Parametro.create(clave: :par_craftar_coleccion_token, valor: token)
        else
          craftar_coleccion.destroy
        end
      end

      return craftar_coleccion || nil
    end
  end

  def craftar_obtener_item(bic)
    if bic && require_craftar
      if collection = craftar_obtener_coleccion
        craftar_item = Craftar::Item.find(bic.craftar_item_uuid)

        if defined?(craftar_item.uuid) and craftar_item.uuid
          nombre = craftar_item.name.split('$').last
          craftar_item.update(
            name: "#{I18n.transliterate(bic.nombre)}$#{nombre}",
            content: {info: bic.historia}.to_json,
            url: "google.es"
          )
        else
          craftar_item = Craftar::Item.create(
            collection: collection.resource_uri,
            name: "#{I18n.transliterate(bic.nombre)}${#{SecureRandom.uuid}}",
            trackable: false,
            content: {info: bic.historia}.to_json,
            custom: {
              info: bic.historia,
              horario: bic.horario
            },
            url: "google.es"
          )
        end

        if bic.destroyed? || !bic.update(
          craftar_item_uuid: craftar_item.uuid,
          craftar_item_resource_uri: craftar_item.resource_uri
        )
          craftar_item.destroy
        end
      end
    end

    return craftar_item || nil
  end

end
