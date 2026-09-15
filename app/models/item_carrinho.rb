class ItemCarrinho < ApplicationRecord
  belongs_to :carrinho
  belongs_to :produto

  validates :quantidade,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }

  def subtotal_centavos
    quantidade * produto.preco_centavos
  end
end