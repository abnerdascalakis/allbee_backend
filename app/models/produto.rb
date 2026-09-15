class Produto < ApplicationRecord
  belongs_to :categoria
  has_many :itens_carrinho, class_name: "ItemCarrinho", dependent: :restrict_with_error
  has_many :itens_pedido, class_name: "ItemPedido", dependent: :nullify

  validates :nome, presence: true
  validates :preco, numericality: { greater_than_or_equal_to: 0 }
  validates :estoque, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
