class ApplicationController < ActionController::API
  rescue_from AppErrors::UnauthorizedUser do |error|
    render json: { errors: error.message }, status: error.http_status
  end
  def encode_token(data)
    JWT.encode(data, 'jwtsecret')
  end

  def get_current_user
    id = decode_token['user_id']
    User.find(id)
  rescue StandardError
    raise AppErrors::UnauthorizedUser
  end

  def decode_token
    token = request.headers['Authorization']
    JWT.decode(token, 'jwtsecret').first
  end
end
