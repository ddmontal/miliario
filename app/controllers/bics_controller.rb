class BicsController < ApplicationController
  def index
    @bics = BicEspacioNatural.all
    @bics.concat BicArtistico.all
  end
end
