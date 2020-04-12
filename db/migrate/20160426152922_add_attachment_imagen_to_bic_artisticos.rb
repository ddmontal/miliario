class AddAttachmentImagenToBicArtisticos < ActiveRecord::Migration
  def self.up
    change_table :bic_artisticos do |t|
      t.attachment :imagen
      t.string :craftar_item_uuid
      t.string :craftar_item_resource_uri
      t.string :craftar_image_uuid
      t.string :cloudinary_image_public_id
    end
  end

  def self.down
    remove_attachment :bic_artisticos, :imagen
    remove_column :bic_artisticos, :craftar_item_uuid
    remove_column :bic_artisticos, :craftar_item_resource_uri
    remove_column :bic_artisticos, :craftar_image_uuid
    remove_column :bic_artisticos, :cloudinary_image_public_id
  end
end
