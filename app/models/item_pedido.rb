class ItemPedido < ApplicationRecord
  belongs_to :pedido
  belongs_to :produto, optional: true

  validates :nome_produto, presence: true

  validates :quantidade,
            numericality: { only_integer: true, greater_than: 0 }

  validates :preco_unitario_centavos,
            :subtotal_centavos,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }
end