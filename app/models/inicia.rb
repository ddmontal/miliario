class Inicia < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :camino
  has_many :realiza, dependent: :destroy
  has_many :etapas, through: :realiza
end
