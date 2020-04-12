class CreateCaminos < ActiveRecord::Migration
  def change
    create_table :caminos do |t|
      t.string :nombre, limit: 50, null: false
      t.string :inicio, limit: 50, null: false
      t.string :fin, length: 50, null: false

      t.timestamps null: false
    end
  end
end
