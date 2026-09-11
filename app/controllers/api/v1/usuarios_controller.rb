class Api::V1::UsuariosController < ApplicationController
  before_action :autenticar_usuario!, only: :perfil

  def create
    usuario = Usuario.new(usuario_params)

    # Todo cadastro público será cliente
    usuario.role = "cliente"

    if usuario.save
      token = JsonWebToken.encode(usuario_id: usuario.id)

      render json: {
        usuario: usuario_json(usuario),
        token: token
      }, status: :created
    else
      render json: {
        erros: usuario.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def perfil
    render json: usuario_json(@usuario_atual), status: :ok
  end

  private

  def usuario_params
    params.require(:usuario).permit(
      :nome,
      :email,
      :password,
      :password_confirmation
    )
  end

  def usuario_json(usuario)
    usuario.as_json(
      only: %i[id nome email role created_at]
    )
  end
end