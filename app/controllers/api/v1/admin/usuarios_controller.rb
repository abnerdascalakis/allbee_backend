class Api::V1::Admin::UsuariosController < ApplicationController
  before_action :autenticar_usuario!
  before_action :autorizar_admin!
  before_action :set_usuario, only: %i[show update destroy]

  def index
    usuarios = Usuario.order(:nome)

    render json: usuarios.as_json(
      only: %i[id nome email role created_at]
    ), status: :ok
  end

  def show
    render json: @usuario.as_json(
      only: %i[id nome email role created_at]
    ), status: :ok
  end

  def update
    if @usuario.update(usuario_params)
      render json: @usuario.as_json(
        only: %i[id nome email role]
      ), status: :ok
    else
      render json: {
        erros: @usuario.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @usuario.destroy!
    head :no_content
  end

  private

  def set_usuario
    @usuario = Usuario.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      erro: "Usuário não encontrado"
    }, status: :not_found
  end

  def usuario_params
    params.require(:usuario).permit(
      :nome,
      :email,
      :role
    )
  end
end