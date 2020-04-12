class Etapa < ActiveRecord::Base
  belongs_to :camino
  has_many :servicios
  has_many :bic_artistico
  has_many :bic_espacios_naturales
  has_many :usuarios, through: :realiza
end
