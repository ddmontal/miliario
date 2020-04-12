class Especie < ActiveRecord::Base
  has_and_belongs_to_many :bic_espacios_naturales
end
