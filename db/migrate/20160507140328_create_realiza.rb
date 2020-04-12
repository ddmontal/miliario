class CreateRealiza < ActiveRecord::Migration
  def change
    create_table :realiza do |t|
      t.references :usuario, index: true, foreign_key: true, null:false
      t.references :inicia, index: true, foreign_key: true, null: false
      t.references :etapa, index: true, foreign_key: true, null: false
      t.date :fecha_inicio, default: 'now()'
      t.date :fecha_fin, default: 'now()'

      t.timestamps null: false
    end
  end
end
