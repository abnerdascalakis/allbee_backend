# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_09_15_170404) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "carrinhos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "usuario_id", null: false
    t.index ["usuario_id"], name: "index_carrinhos_on_usuario_id", unique: true
  end

  create_table "categorias", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "nome"
    t.datetime "updated_at", null: false
  end

  create_table "enderecos", force: :cascade do |t|
    t.string "bairro"
    t.string "cep"
    t.string "cidade"
    t.string "complemento"
    t.datetime "created_at", null: false
    t.string "logradouro"
    t.string "nome_destinatario"
    t.string "numero"
    t.boolean "principal"
    t.string "telefone_destinatario"
    t.datetime "updated_at", null: false
    t.bigint "usuario_id", null: false
    t.index ["usuario_id"], name: "index_enderecos_on_usuario_id"
  end

  create_table "item_carrinhos", force: :cascade do |t|
    t.bigint "carrinho_id", null: false
    t.datetime "created_at", null: false
    t.bigint "produto_id", null: false
    t.integer "quantidade", default: 1, null: false
    t.datetime "updated_at", null: false
    t.index ["carrinho_id", "produto_id"], name: "index_item_carrinhos_on_carrinho_id_and_produto_id", unique: true
    t.index ["carrinho_id"], name: "index_item_carrinhos_on_carrinho_id"
    t.index ["produto_id"], name: "index_item_carrinhos_on_produto_id"
  end

  create_table "item_pedidos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "nome_produto", null: false
    t.bigint "pedido_id", null: false
    t.integer "preco_unitario_centavos", null: false
    t.bigint "produto_id"
    t.integer "quantidade", null: false
    t.integer "subtotal_centavos", null: false
    t.datetime "updated_at", null: false
    t.index ["pedido_id"], name: "index_item_pedidos_on_pedido_id"
    t.index ["produto_id"], name: "index_item_pedidos_on_produto_id"
  end

  create_table "pedidos", force: :cascade do |t|
    t.string "bairro", null: false
    t.string "cep", null: false
    t.string "cidade", null: false
    t.string "complemento"
    t.datetime "created_at", null: false
    t.integer "desconto_centavos", default: 0, null: false
    t.bigint "endereco_id"
    t.integer "frete_centavos", default: 0, null: false
    t.string "logradouro", null: false
    t.string "nome_destinatario", null: false
    t.string "numero", null: false
    t.string "status", default: "aguardando_pagamento", null: false
    t.integer "subtotal_centavos", default: 0, null: false
    t.string "telefone_destinatario"
    t.integer "total_centavos", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "usuario_id", null: false
    t.index ["created_at"], name: "index_pedidos_on_created_at"
    t.index ["endereco_id"], name: "index_pedidos_on_endereco_id"
    t.index ["status"], name: "index_pedidos_on_status"
    t.index ["usuario_id"], name: "index_pedidos_on_usuario_id"
  end

  create_table "produtos", force: :cascade do |t|
    t.bigint "categoria_id", null: false
    t.datetime "created_at", null: false
    t.text "descricao"
    t.integer "estoque", default: 0, null: false
    t.string "nome", null: false
    t.decimal "preco", precision: 10, scale: 2, null: false
    t.datetime "updated_at", null: false
    t.index ["categoria_id"], name: "index_produtos_on_categoria_id"
    t.check_constraint "estoque >= 0", name: "produtos_estoque_nao_negativo"
    t.check_constraint "preco >= 0::numeric", name: "produtos_preco_nao_negativo"
  end

  create_table "usuarios", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "nome", null: false
    t.string "password_digest", null: false
    t.string "role", default: "cliente", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_usuarios_on_email", unique: true
  end

  add_foreign_key "carrinhos", "usuarios"
  add_foreign_key "enderecos", "usuarios"
  add_foreign_key "item_carrinhos", "carrinhos"
  add_foreign_key "item_carrinhos", "produtos"
  add_foreign_key "item_pedidos", "pedidos"
  add_foreign_key "item_pedidos", "produtos"
  add_foreign_key "pedidos", "enderecos"
  add_foreign_key "pedidos", "usuarios"
  add_foreign_key "produtos", "categorias"
end
