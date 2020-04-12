class CreateJoinTableBicEspaciosNaturalesEspecies < ActiveRecord::Migration
  def change
    create_join_table :bic_espacios_naturales, :especies do |t|
      # t.index [:bic_espacio_natural_id, :especie_id]
      # t.index [:especie_id, :bic_espacio_natural_id]
    end
  end
end
