class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include Response
  include ExceptionHandler

  def respond_with_errors(object)
    render json: { errors: ErrorSerializer.serialize(object) }, status: :unprocessable_entity
  end
end