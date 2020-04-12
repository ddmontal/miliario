class Utiliza < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :servicio
  belongs_to :realiza
end
