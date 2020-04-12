json.array!(@parametros) do |parametro|
  json.extract! parametro, :id, :clave, :valor
  json.url parametro_url(parametro, format: :json)
end
