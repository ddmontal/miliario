class Realiza < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :etapa
  belongs_to :inicia
  has_many :utiliza, dependent: :destroy
  has_many :servicios, through: :utiliza
end
