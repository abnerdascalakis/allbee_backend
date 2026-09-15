class CreatePedidos < ActiveRecord::Migration[8.1]
  def change
    create_table :pedidos do |t|
      t.references :usuario, null: false, foreign_key: true
      t.references :endereco, null: true, foreign_key: true

      t.string :status, null: false, default: "aguardando_pagamento"

      t.integer :subtotal_centavos, null: false, default: 0
      t.integer :frete_centavos, null: false, default: 0
      t.integer :desconto_centavos, null: false, default: 0
      t.integer :total_centavos, null: false, default: 0

      t.string :nome_destinatario, null: false
      t.string :telefone_destinatario
      t.string :cep, null: false
      t.string :logradouro, null: false
      t.string :numero, null: false
      t.string :complemento
      t.string :bairro, null: false
      t.string :cidade, null: false

      t.timestamps
    end

    add_index :pedidos, :status
    add_index :pedidos, :created_at
  end
end