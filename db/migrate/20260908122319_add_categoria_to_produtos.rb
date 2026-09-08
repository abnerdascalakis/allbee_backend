class AddCategoriaToProdutos < ActiveRecord::Migration[8.1]
  def up
    rename_table :categoria, :categorias
    add_reference :produtos, :categoria, null: true, foreign_key: true

    categoria_id = select_value(<<~SQL.squish)
      INSERT INTO categorias (nome, created_at, updated_at)
      VALUES ('Sem categoria', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
      RETURNING id
    SQL

    execute <<~SQL.squish
      UPDATE produtos
      SET categoria_id = #{connection.quote(categoria_id)}
      WHERE categoria_id IS NULL
    SQL

    change_column_null :produtos, :categoria_id, false
  end

  def down
    remove_reference :produtos, :categoria, foreign_key: true
    rename_table :categorias, :categoria
  end
end
