class CreateBicEspaciosNaturales < ActiveRecord::Migration
  def change
    create_table :bic_espacios_naturales do |t|
      # t.references :camino, index: true, foreign_key: true
      t.references :etapa, index: true, foreign_key: true
      t.string :nombre, null: false
      t.string :localizacion, default: ''
      t.st_point :coordenadas, default: 'point(0 0)'
      t.text :historia, default: ''
      t.string :horario, default: ''
      t.integer :numero_visitas, default: 0
      t.integer :extension, default: ''

      t.timestamps null: false
    end
  end
end
