class Api::V1::ProdutosController < ApplicationController
  before_action :set_produto, only: %i[show update destroy]

  def index
    render json: Produto.all, status: :ok
  end

  def show
    render json: @produto, status: :ok
  end

  def create
    produto = Produto.new(produto_params)

    if produto.save
      render json: produto, status: :created
    else
      render json: { erros: produto.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @produto.update(produto_params)
      render json: @produto, status: :ok
    else
      render json: { erros: @produto.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @produto.destroy!
    head :no_content
  end

  private

  def set_produto
    @produto = Produto.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { erro: "Produto não encontrado" }, status: :not_found
  end

  def produto_params
    params.expect(produto: %i[nome preco descricao estoque categoria_id])
  end
end
