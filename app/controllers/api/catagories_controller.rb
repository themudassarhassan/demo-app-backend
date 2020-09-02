class Api::CatagoriesController < ApplicationController
  def index
    @catagories = ProductCatagory.all
    render json: @catagories, status: 200
  end
end
