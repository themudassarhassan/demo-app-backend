class Api::CommentsController < ApplicationController
  def create
    user = get_current_user
    @comment = Comment.new(comment_params)
    @comment.user_id = user.id
    @comment.save
    render json: @comment, status: 201
  end

  def update; end

  def delete; end

  private

  def comment_params
    params.permit(:comment, :product_id)
  end
end
