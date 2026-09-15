class CreateEnderecos < ActiveRecord::Migration[8.1]
  def change
    create_table :enderecos do |t|
      t.references :usuario, null: false, foreign_key: true
      t.string :nome_destinatario
      t.string :telefone_destinatario
      t.string :cep
      t.string :logradouro
      t.string :numero
      t.string :complemento
      t.string :bairro
      t.string :cidade
      t.boolean :principal

      t.timestamps
    end
  end
end
