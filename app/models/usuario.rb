class Usuario < ApplicationRecord
  has_secure_password
  has_many :enderecos, dependent: :destroy

  ROLES = %w[cliente admin].freeze

  before_validation :normalizar_email

  validates :nome, presence: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :role,
            presence: true,
            inclusion: { in: ROLES }

  validates :password,
            length: { minimum: 8 },
            allow_nil: true

  def admin?
    role == "admin"
  end

  def cliente?
    role == "cliente"
  end

  private

  def normalizar_email
    self.email = email.to_s.strip.downcase
  end
end