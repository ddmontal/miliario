# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160612144349) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "attachinary_files", force: :cascade do |t|
    t.integer  "attachinariable_id"
    t.string   "attachinariable_type"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachinary_files", ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree

  create_table "bic_artisticos", force: :cascade do |t|
    t.integer  "etapa_id"
    t.string   "nombre",                                                                                                                                null: false
    t.string   "localizacion",                                                  default: ""
    t.geometry "coordenadas",                limit: {:srid=>0, :type=>"point"}, default: #<RGeo::Geos::CAPIPointImpl:0x3fff624b02c0 "POINT (0.0 0.0)">
    t.text     "historia",                                                      default: ""
    t.string   "horario",                                                       default: ""
    t.integer  "numero_visitas",                                                default: 0
    t.string   "tipo",                                                          default: ""
    t.string   "estilo",                                                        default: ""
    t.datetime "created_at",                                                                                                                            null: false
    t.datetime "updated_at",                                                                                                                            null: false
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
    t.string   "craftar_item_uuid"
    t.string   "craftar_item_resource_uri"
    t.string   "craftar_image_uuid"
    t.string   "cloudinary_image_public_id"
  end

  add_index "bic_artisticos", ["etapa_id"], name: "index_bic_artisticos_on_etapa_id", using: :btree

  create_table "bic_espacios_naturales", force: :cascade do |t|
    t.integer  "etapa_id"
    t.string   "nombre",                                                                                                                         null: false
    t.string   "localizacion",                                           default: ""
    t.geometry "coordenadas",         limit: {:srid=>0, :type=>"point"}, default: #<RGeo::Geos::CAPIPointImpl:0x3fff63841dd4 "POINT (0.0 0.0)">
    t.text     "historia",                                               default: ""
    t.string   "horario",                                                default: ""
    t.integer  "numero_visitas",                                         default: 0
    t.integer  "extension"
    t.datetime "created_at",                                                                                                                     null: false
    t.datetime "updated_at",                                                                                                                     null: false
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
  end

  add_index "bic_espacios_naturales", ["etapa_id"], name: "index_bic_espacios_naturales_on_etapa_id", using: :btree

  create_table "bic_espacios_naturales_especies", id: false, force: :cascade do |t|
    t.integer "bic_espacio_natural_id", null: false
    t.integer "especie_id",             null: false
  end

  create_table "caminos", force: :cascade do |t|
    t.string   "nombre",     limit: 50, null: false
    t.string   "inicio",     limit: 50, null: false
    t.string   "fin",                   null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "especies", force: :cascade do |t|
    t.string   "nombre_cientifico"
    t.string   "nombre_vulgar"
    t.text     "descripcion"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "etapas", force: :cascade do |t|
    t.integer  "camino_id"
    t.integer  "posicion"
    t.string   "comienzo",                           null: false
    t.string   "fin",                                null: false
    t.decimal  "distancia",  precision: 5, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "etapas", ["camino_id"], name: "index_etapas_on_camino_id", using: :btree

  create_table "inicia", force: :cascade do |t|
    t.integer  "usuario_id"
    t.integer  "camino_id"
    t.date     "fecha_inicio",  default: '2016-06-12'
    t.date     "fecha_fin",     default: '2016-06-12'
    t.text     "motivo",        default: ""
    t.string   "modo",          default: ""
    t.string   "punto_partida", default: ""
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "inicia", ["camino_id"], name: "index_inicia_on_camino_id", using: :btree
  add_index "inicia", ["usuario_id"], name: "index_inicia_on_usuario_id", using: :btree

  create_table "parametros", force: :cascade do |t|
    t.string   "clave"
    t.string   "valor"
    t.boolean  "multi",      default: false
    t.boolean  "bloqueado",  default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "realiza", force: :cascade do |t|
    t.integer  "usuario_id",                          null: false
    t.integer  "inicia_id",                           null: false
    t.integer  "etapa_id",                            null: false
    t.date     "fecha_inicio", default: '2016-06-12'
    t.date     "fecha_fin",    default: '2016-06-12'
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "realiza", ["etapa_id"], name: "index_realiza_on_etapa_id", using: :btree
  add_index "realiza", ["inicia_id"], name: "index_realiza_on_inicia_id", using: :btree
  add_index "realiza", ["usuario_id"], name: "index_realiza_on_usuario_id", using: :btree

  create_table "servicios", force: :cascade do |t|
    t.integer  "etapa_id"
    t.string   "nombre"
    t.string   "localizacion"
    t.geometry "coordenadas",    limit: {:srid=>0, :type=>"point"}, default: #<RGeo::Geos::CAPIPointImpl:0x3fff6380d3f4 "POINT (0.0 0.0)">
    t.string   "horario",                                           default: ""
    t.string   "telefono",                                          default: ""
    t.string   "tipo",                                              default: ""
    t.string   "disponibilidad",                                    default: ""
    t.datetime "created_at",                                                                                                                null: false
    t.datetime "updated_at",                                                                                                                null: false
  end

  add_index "servicios", ["etapa_id"], name: "index_servicios_on_etapa_id", using: :btree

  create_table "usuarios", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "alias",                  default: "",    null: false
    t.boolean  "admin",                  default: false
    t.string   "nombre",                 default: ""
    t.string   "procedencia",            default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree

  create_table "utiliza", force: :cascade do |t|
    t.integer  "usuario_id"
    t.integer  "servicio_id"
    t.integer  "realiza_id"
    t.date     "fecha",       default: '2016-06-12'
    t.text     "critica",     default: ""
    t.integer  "nota",        default: 5
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "utiliza", ["realiza_id"], name: "index_utiliza_on_realiza_id", using: :btree
  add_index "utiliza", ["servicio_id"], name: "index_utiliza_on_servicio_id", using: :btree
  add_index "utiliza", ["usuario_id"], name: "index_utiliza_on_usuario_id", using: :btree

  add_foreign_key "bic_artisticos", "etapas"
  add_foreign_key "bic_espacios_naturales", "etapas"
  add_foreign_key "etapas", "caminos"
  add_foreign_key "inicia", "caminos"
  add_foreign_key "inicia", "usuarios"
  add_foreign_key "realiza", "etapas"
  add_foreign_key "realiza", "inicia"
  add_foreign_key "realiza", "usuarios"
  add_foreign_key "servicios", "etapas"
  add_foreign_key "utiliza", "realiza"
  add_foreign_key "utiliza", "servicios"
  add_foreign_key "utiliza", "usuarios"
end
