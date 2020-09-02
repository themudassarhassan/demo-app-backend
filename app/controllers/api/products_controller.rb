class Api::ProductsController < ApplicationController
  before_action :set_product, only: %i[update destroy]
  def create
    user = get_current_user
    @product = Product.new(product_params)
    @product.user_id = user.id
    @product.save!
    render json: @product, status: 201
   end

  def show
    @product = Product.find(params[:id])
    send_product_with_details
  end

  def my_products
    user = get_current_user
    @products = Product.where(user_id: user.id)
    send_products
  end

  def update
    if @product
      @product.update(product_params)
      render json: @product, status: 200
    else
      render json: { message: 'Product does not exist.' }, status: 404
    end
  end

  def destroy
    @product.destroy
    render json: { message: 'The product deleted successfully.' }, status: 200
   end

  def index
    @products = Product.all
    send_products
   end

  private

  def set_product
    user = get_current_user
    @product = Product.where('id = ? and user_id = ?', params[:id], user.id).first
  end

  def send_products
    response = []
    @products.each do |prod|
      response.push({ id: prod.id, name: prod.name, catagory: prod.product_catagory.name,
                      price: prod.price, img: prod.get_image_url })
    end
    render json: response, status: 200
  end

  def product_params
    # print JSON.parse(params[:images])
    params.permit(:name, :price, :quantity, :product_catagory_id, :image)
  end

  def format_comments
    comments = []
    @product.comments.each do |item|
      comments.push({ user: { name: item.user.name, id: item.user.id },
                      comment: item.comment, feedback: item.feedback, date: item.created_at })
    end
    comments
  end

  def send_product_with_details
    response = { id: @product.id, name: @product.name, price: @product.price,
                 quantity: @product.quantity,
                 comments: format_comments,
                 img: @product.get_image_url,
                 user: { name: @product.user.name, id: @product.user.id } }
    render json: response, status: 200
  end
end
