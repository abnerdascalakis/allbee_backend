class Carrinho < ApplicationRecord
  belongs_to :usuario

  has_many :itens_carrinho,
           class_name: "ItemCarrinho",
           dependent: :destroy

  has_many :produtos, through: :itens_carrinho
end