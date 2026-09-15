class Pedido < ApplicationRecord
  STATUS = %w[
    aguardando_pagamento
    pago
    preparando
    enviado
    entregue
    cancelado
  ].freeze

  belongs_to :usuario
  belongs_to :endereco, optional: true

  has_many :itens_pedido,
           class_name: "ItemPedido",
           dependent: :destroy

  validates :status, presence: true, inclusion: { in: STATUS }

  validates :subtotal_centavos,
            :frete_centavos,
            :desconto_centavos,
            :total_centavos,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  validates :nome_destinatario,
            :cep,
            :logradouro,
            :numero,
            :bairro,
            :cidade,
            presence: true
end