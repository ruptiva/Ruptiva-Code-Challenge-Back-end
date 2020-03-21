# frozen_string_literal: true

class ApplicationController < ActionController::API
  respond_to :json
  delegate :t, to: I18n

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user, unless: :devise_controller?

  private

  def token
    request.headers['Authorization']
  end

  def authenticate_user
    user = User&.find_by(authentication_token: token)
    if user && token.present?
      @current_user = user
    else
      render json: {
        errors: t('activerecord.errors.messages.user.unauthorized')
      }, status: :unauthorized
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  def success_response(data:, model:, includes: '', status: :ok)
    return unless data || model

    render json: data, serializer: "Api::V1::#{model}Serializer".constantize,
           includes: includes.split(','), status: status
  end

  def error_response(data:)
    return unless data

    render json: data.errors, status: :unprocessable_entity
  end
end
