class CreateInicia < ActiveRecord::Migration
  def change
    create_table :inicia do |t|
      t.references :usuario, index: true, foreign_key: true
      t.references :camino, index: true, foreign_key: true
      t.date :fecha_inicio, default: 'now()'
      t.date :fecha_fin, default: 'now()'
      t.text :motivo, default: ''
      t.string :modo, default: ''
      t.string :punto_partida, default: ''

      t.timestamps null: false
    end
  end
end
