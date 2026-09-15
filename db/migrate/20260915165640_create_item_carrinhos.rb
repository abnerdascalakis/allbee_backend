class CreateItemCarrinhos < ActiveRecord::Migration[8.1]
  def change
    create_table :item_carrinhos do |t|
      t.references :carrinho, null: false, foreign_key: true
      t.references :produto, null: false, foreign_key: true
      t.integer :quantidade, null: false, default: 1

      t.timestamps
    end

    add_index :item_carrinhos,
              [:carrinho_id, :produto_id],
              unique: true
  end
end
