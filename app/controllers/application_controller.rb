class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  def success_response(data = [], status = :ok)
    render json: { "success": true, "data": data.as_json, status: status }, status: status
  end

  def error_response(error = [], status = :unprocessable_entity, message = "")
    render json: { "success": false, "error": error.as_json, status: status, "message": message }, status: status
  end

  def checkAdmin()
    current_member.class.is_a? Admin.class
  end

  def user_not_authorized
    error_response("You are not authorized to perform this action.")
  end

end
