class ProductsController < ApplicationController
    before_action :set_product, only: %i[ show edit update destroy ]

    allow_unauthenticated_access only: %i[ index show ]

    def index
        @products = Product.all
    end

    def show
    end

    def new
        @product = Product.new
    end

    # handles the data submitted by the form but needs to be filtered
    def create
        # asking params defined in private
        @product = Product.new(product_params)

        if @product.save
            redirect_to @product
        else
            # :new es la vista de crear nuevo producto
            # http status 422 -> unprocessable entity to tell the browser this post request failed
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @product.update(product_params)
            redirect_to @product
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @product.destroy

        redirect_to products_path
    end

=begin
  product params ask to inspect the params and ensure
  there is a key name :product and the only parameter permited is name
=end

    private
        def set_product
            @product = Product.find(params[:id])
        end

        def product_params
            params.expect(product: [ :name, :description, :featured_image, :inventory_count ])
        end
end
