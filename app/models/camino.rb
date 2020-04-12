class Camino < ActiveRecord::Base
  has_many :etapas
  has_many :inicia
  has_many :usuarios, through: :inicia
  validates :nombre, uniqueness: true
end
