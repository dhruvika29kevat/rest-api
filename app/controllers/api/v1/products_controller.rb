class Api::V1::ProductsController < ApplicationController
    before_action :find_product, only: [:show, :update,:destroy]

    def index
        @products = Product.all
        render json: @products
    end

    def show
        render json: @product
    end

    def create
        @product = Product.new(product_params)
        if @product.save
            render json: @product
        else
            render error: {error: 'Unable to create product!!!'}, status: 400
        end
    end

    def update
        if @product
            @product.update(product_params)
            render json: {message: 'Product successfully updated.'}, status: 200
        else
            render json: {error: 'Unable to update Product.!!!'}, status: 400
        end
    end

    def destroy
        if @product
            @product.destroy
            render json: {message: 'Product deleted.'}, status: 200
        else
            render json: {error: 'Unable to delete Product!!!'}, status: 400
        end
    end

    private

    def product_params
        params.require(:product).permit(:title, :description, :user_id)
    end

    def find_product
        @product = Product.find(params[:id])
    end
end
