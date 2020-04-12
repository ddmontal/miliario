class Servicio < ActiveRecord::Base
  belongs_to :etapa
  has_many :usuarios, through: :utiliza

  validates :nombre, uniqueness: true
  validates :etapa, presence: true
  validates :tipo, inclusion: { in: :tipos_servicio_todo }

  def tipos_servicio_todo
    tipos_servicio_alojamiento +
    tipos_servicio_restauracion +
    tipos_servicio_sanidad +
    tipos_servicio_seguridad +
    tipos_servicio_transporte
  end

  def tipos_servicio_alojamiento
    Parametro.find_by(clave: :tipos_servicio_alojamiento).valor
  end

  def tipos_servicio_restauracion
    Parametro.find_by(clave: :tipos_servicio_restauracion).valor
  end

  def tipos_servicio_sanidad
    Parametro.find_by(clave: :tipos_servicio_sanidad).valor
  end

  def tipos_servicio_seguridad
    Parametro.find_by(clave: :tipos_servicio_seguridad).valor
  end

  def tipos_servicio_transporte
    Parametro.find_by(clave: :tipos_servicio_transporte).valor
  end

  def alojamiento?
    tipos_servicio_alojamiento.include? self.tipo
  end

  def restauracion?
    tipos_servicio_restauracion.include? self.tipo
  end

  def sanidad?
    tipos_servicio_sanidad.include? self.tipo
  end

  def seguridad?
    tipos_servicio_seguridad.include? self.tipo
  end

  def transporte?
    tipos_servicio_transporte.include? self.tipo
  end

end
