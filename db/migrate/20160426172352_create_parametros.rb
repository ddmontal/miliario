class CreateParametros < ActiveRecord::Migration
  def change
    create_table :parametros do |t|
      t.string :clave
      t.string :valor
      t.boolean :multi, default: false
      t.boolean :bloqueado, default: true

      t.timestamps null: false
    end
  end
end
