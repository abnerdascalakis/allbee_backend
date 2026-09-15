class Endereco < ApplicationRecord
  belongs_to :usuario
  has_many :pedidos, dependent: :nullify

  before_validation :normalizar_cep
  before_validation :normalizar_telefone

  validates :nome_destinatario, presence: true
  validates :telefone_destinatario, presence: true
  validates :cep, presence: true,
                  format: {
                    with: /\A\d{8}\z/,
                    message: "deve conter 8 números"
                  }
  validates :logradouro, presence: true
  validates :numero, presence: true
  validates :bairro, presence: true
  validates :cidade, presence: true

  private

  def normalizar_cep
    self.cep = cep.to_s.gsub(/\D/, "")
  end

  def normalizar_telefone
    self.telefone_destinatario =
      telefone_destinatario.to_s.gsub(/\D/, "")
  end
end