class BicArtistico < ActiveRecord::Base
  belongs_to :etapa
  has_attachment  :imagen, accept: [:jpg, :png, :gif]

  # has_attached_file :imagen, styles: {
  #   large: "1000x1000>", medium: "300x300>", thumb: "100x100#"
  # }, default_url: "/images/:style/missing.png"
  #
  # validates_attachment_content_type :imagen, content_type: /\Aimage\/.*\Z/
end
