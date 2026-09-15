class ApplicationController < ActionController::API
  private

  def autenticar_usuario!
    token = request.headers["Authorization"]&.split&.last

    if token.blank?
      return render json: {
        erro: "Token não informado"
      }, status: :unauthorized
    end

    payload = JsonWebToken.decode(token)
    @usuario_atual = Usuario.find(payload["usuario_id"])
  rescue JWT::DecodeError, JWT::ExpiredSignature
    render json: {
      erro: "Token inválido ou expirado"
    }, status: :unauthorized
  rescue ActiveRecord::RecordNotFound
    render json: {
      erro: "Usuário não encontrado"
    }, status: :unauthorized
  end

  def autorizar_admin!
    return if @usuario_atual&.admin?

    render json: {
      erro: "Acesso permitido somente para administradores"
    }, status: :forbidden
  end
end