class CreateCarrinhos < ActiveRecord::Migration[8.1]
  def change
    create_table :carrinhos do |t|
      t.references :usuario, null: false, foreign_key: true
      t.string :status, null: false, default: "ativo"

      t.timestamps
    end

    add_index :carrinhos,
              :usuario_id,
              unique: true,
              where: "status = 'ativo'",
              name: "index_carrinho_ativo_por_usuario"
  end
end