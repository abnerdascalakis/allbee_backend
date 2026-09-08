class Produto < ApplicationRecord
  belongs_to :categoria

  validates :nome, presence: true
  validates :preco, numericality: { greater_than_or_equal_to: 0 }
  validates :estoque, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
