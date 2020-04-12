class CreateBicArtisticos < ActiveRecord::Migration
  def change
    create_table :bic_artisticos do |t|
      t.references :etapa, index: true, foreign_key: true
      t.string :nombre, null: false
      t.string :localizacion, default: ''
      t.st_point :coordenadas, default: 'point(0 0)'
      t.text :historia, default: ''
      t.string :horario, default: ''
      t.integer :numero_visitas, default: 0
      t.string :tipo, default: ''
      t.string :estilo, default: ''

      t.timestamps null: false
    end
  end
end
