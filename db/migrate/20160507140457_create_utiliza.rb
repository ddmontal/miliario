class CreateUtiliza < ActiveRecord::Migration
  def change
    create_table :utiliza do |t|
      t.references :usuario, index: true, foreign_key: true
      t.references :servicio, index: true, foreign_key: true
      t.references :realiza, index: true, foreign_key: true
      t.date :fecha, default: 'now()'
      t.text :critica, default: ''
      t.integer :nota, default: 5

      t.timestamps null: false
    end
  end
end
