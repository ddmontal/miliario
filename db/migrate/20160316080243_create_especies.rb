class CreateEspecies < ActiveRecord::Migration
  def change
    create_table :especies do |t|
      t.string :nombre_cientifico
      t.string :nombre_vulgar
      t.text :descripcion

      t.timestamps null: false
    end
  end
end
