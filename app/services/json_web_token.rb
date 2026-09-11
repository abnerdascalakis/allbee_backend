class JsonWebToken
  ALGORITHM = "HS256"

  def self.encode(payload)
    payload = payload.merge(
      exp: 6.hours.from_now.to_i
    )

    JWT.encode(
      payload,
      Rails.application.secret_key_base,
      ALGORITHM
    )
  end

  def self.decode(token)
    JWT.decode(
      token,
      Rails.application.secret_key_base,
      true,
      algorithm: ALGORITHM
    ).first
  end
end

# token identifica o usuario logado, depois do tempo de expiração a sessão do usuario expira.