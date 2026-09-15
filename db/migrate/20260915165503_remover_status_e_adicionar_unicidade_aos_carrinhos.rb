class RemoverStatusEAdicionarUnicidadeAosCarrinhos < ActiveRecord::Migration[8.1]
  def change
    remove_column :carrinhos, :status, :string

    remove_index :carrinhos, :usuario_id, if_exists: true
    add_index :carrinhos, :usuario_id, unique: true
  end
end