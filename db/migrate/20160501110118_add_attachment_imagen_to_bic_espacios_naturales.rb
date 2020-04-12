class AddAttachmentImagenToBicEspaciosNaturales < ActiveRecord::Migration
  def self.up
    change_table :bic_espacios_naturales do |t|
      t.attachment :imagen
    end
  end

  def self.down
    remove_attachment :bic_espacios_naturales, :imagen
  end
end
