class Api::V1::CategoriasController < ApplicationController
  before_action :set_categoria, only: %i[show update destroy]

  def index
    render json: Categoria.order(:nome), status: :ok
  end

  def show
    render json: @categoria, status: :ok
  end

  def create
    categoria = Categoria.new(categoria_params)

    if categoria.save
      render json: categoria, status: :created
    else
      render json: { erros: categoria.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @categoria.update(categoria_params)
      render json: @categoria, status: :ok
    else
      render json: { erros: @categoria.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @categoria.destroy
      head :no_content
    else
      render json: { erros: @categoria.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_categoria
    @categoria = Categoria.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { erro: "Categoria não encontrada" }, status: :not_found
  end

  def categoria_params
    params.expect(categoria: [:nome])
  end
end
