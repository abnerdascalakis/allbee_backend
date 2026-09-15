class CreateItemPedidos < ActiveRecord::Migration[8.1]
  def change
    create_table :item_pedidos do |t|
      t.references :pedido, null: false, foreign_key: true
      t.references :produto, null: true, foreign_key: true

      t.string :nome_produto, null: false
      t.integer :preco_unitario_centavos, null: false
      t.integer :quantidade, null: false
      t.integer :subtotal_centavos, null: false

      t.timestamps
    end
  end
end
