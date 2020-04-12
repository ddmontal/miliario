module ApplicationHelper
  def js_onclick(url)
    'onclick='+'"'+"window.location='#{url}'"+'"'
  end

  def resource_name
    :usuario
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:usuario]
  end

  def aviso_datos_temporales
    "<p class=\"lead bg-warning text-center\">
      #{I18n.t('aviso_datos_temporales')}
    </p>"
  end
end
