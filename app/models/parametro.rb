class Parametro < ActiveRecord::Base
  validates :clave, uniqueness: true
  symbolize :clave
  serialize :valor
end
