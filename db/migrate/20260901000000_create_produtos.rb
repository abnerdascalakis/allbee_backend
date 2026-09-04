class CreateProdutos < ActiveRecord::Migration[8.1]
  def change
    create_table :produtos do |t|
      t.string :nome, null: false
      t.decimal :preco, precision: 10, scale: 2, null: false
      t.text :descricao
      t.integer :estoque, null: false, default: 0

      t.timestamps
    end

    add_check_constraint :produtos, "preco >= 0", name: "produtos_preco_nao_negativo"
    add_check_constraint :produtos, "estoque >= 0", name: "produtos_estoque_nao_negativo"
  end
end
