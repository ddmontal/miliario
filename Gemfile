# ruby "2.5.1"
source "https://rubygems.org"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "4.2.6"

# Usar puma como servidor por defecto
gem "puma"

# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.1.0"
# Use jquery as the JavaScript library
gem "jquery-rails"
gem "jquery-turbolinks"
# Turbolinks makes following links in your web application faster.
# Read more: https://github.com/rails/turbolinks
gem "turbolinks"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.0"
# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", "~> 0.4.0", group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

platforms :jruby do
  # Use jdbcpostgresql as the database for Active Record
  gem "activerecord-jdbcpostgresql-adapter"
  # See https://github.com/rails/execjs#readme for more supported runtimes
  gem "therubyrhino"
end

platforms :ruby do
  # Use postgresql as the database for Active Record
  gem "postgresql"
  gem "thread_safe"
  # gem 'unicorn-rails'
end

# Iconos Font awesome
gem "font-awesome-sass"
# Autoprefixer
gem "autoprefixer-rails"
# Bootstrap
gem "bootstrap-sass"
# Geoposicionamiento en la base de datos
gem "activerecord-postgis-adapter"
# Google Maps
gem "gmaps4rails"
gem "underscore-rails"
# Geocoder
gem "geocoder"
# Jquery UI
gem "jquery-ui-rails"
# Barra de progreso
gem "nprogress-rails"

# Craft AR Management SDK
gem "httparty", "~> 0.13.7"
gem "httmultiparty", "~> 0.3.16"
gem "craftar", "0.0.9.3", require: false
# Gestionar idiomas del cliente
gem "http_accept_language"
# Subir imágenes nube
gem "cloudinary"
# Gestion de usuarios, devise
gem "devise"
gem "rails_12factor", group: :production

# Gestionar imagenes
# gem "paperclip", "~> 5.0.0.beta1"
gem "attachinary"

# Aviso Cookies EU
gem "cookies_eu"
