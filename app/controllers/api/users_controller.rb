class Api::UsersController < ApplicationController
  before_action :find_user, only: %i[verify_email reset_password]
  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      send_user_with_auth
    else
      render json: { error: 'Username or password is not correct' }, status: 401
    end
  end

  def signup
    @user = User.create(user_params)
    if @user.valid?
      send_user_with_auth
    else
      render json: { errors: @user.errors }, status: 400
    end
  end

  def update
    @user = get_current_user
    @user.name = params[:name] if params[:name]
    @user.image = params[:image] if params[:image]
    @user.save
    send_user_with_auth
  end

  def update_password
    @user = get_current_user
    if @user.authenticate(params[:oldPassword])
      @user.password = params[:newPassword]
      @user.save
      send_user
    else
      render json: { errors: 'Old password is not correct' }, status: 400
    end
  end

  def verify_email
    if @user
      reset_token = rand(1000..9999)
      @user.update(reset_token: reset_token)

      UserMailer.with(data: { email: params[:email], token: reset_token })
                .password_reset_token_email.deliver_later
      render json: { message: 'a reset token has been sent. check your email!' }, status: 200
    else
      render json: { message: 'email not found.' }, status: 404
    end
  end

  def reset_password
    if @user && @user[:reset_token] == Integer(params[:token])
      @user.password = params[:password]
      @user.save
      render json: { message: 'password reset successfully.' }, status: 200
    else
      render json: { message: 'token not verified.' }, status: 400
    end
  end

  def find_user
    @user = User.find_by(email: params[:email])
  end

  private

  def send_user
    response = { id: @user.id, name: @user.name, email: @user.email, img_url: @user.get_image_url }
    render json: response, status: 200
  end

  def send_user_with_auth
    token = encode_token({ user_id: @user.id })
    response = { id: @user.id, name: @user.name, email: @user.email,
                 img_url: @user.get_image_url, token: token }
    render json: response, status: 200
  end

  def user_params
    params.permit(:name, :email, :password, :image)
  end
end
