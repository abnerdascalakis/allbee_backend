class Api::V1::SessoesController < ApplicationController
  def create
    email = params[:email].to_s.strip.downcase
    usuario = Usuario.find_by(email: email)

    if usuario&.authenticate(params[:password])
      token = JsonWebToken.encode(usuario_id: usuario.id)

      render json: {
        usuario: usuario.as_json(
          only: %i[id nome email role]
        ),
        token: token
      }, status: :ok
    else
      render json: {
        erro: "E-mail ou senha inválidos"
      }, status: :unauthorized
    end
  end
end