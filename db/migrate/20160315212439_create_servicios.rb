class CreateServicios < ActiveRecord::Migration
  def change
    create_table :servicios do |t|
      t.references :etapa, index: true, foreign_key: true
      t.string :nombre
      t.string :localizacion
      t.st_point :coordenadas, default: 'point(0 0)'
      t.string :horario, default: ''
      t.string :telefono, default: ''
      t.string :tipo, default: ''
      t.string :disponibilidad, default: ''

      t.timestamps null: false
    end
  end
end
