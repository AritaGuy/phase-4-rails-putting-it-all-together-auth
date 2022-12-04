class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :authorized, only: :show

rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  def authorized
    return render json: {error: "Not Authorized"}, status: :unauthorized unless session.include? :user_id
  end

  def render_unprocessable_entity(invalid)
    return render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end

end
