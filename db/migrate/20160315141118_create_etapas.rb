class CreateEtapas < ActiveRecord::Migration
  def change
    create_table :etapas do |t|
      t.references :camino, index: true, foreign_key: true
      t.integer :posicion
      t.string :comienzo, null: false
      t.string :fin, null: false
      t.decimal :distancia, precision: 5, scale: 2

      t.timestamps null: false
    end
  end
end
