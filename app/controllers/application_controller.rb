# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  respond_to :json
  delegate :t, to: I18n

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user, unless: :devise_controller?

  private

  def token
    request.headers['Authorization']
  end

  def authenticate_user
    user = User&.find_by_authentication_token(token)
    if user && token.present?
      @current_user = user
    else
      render json: {
        errors: t('activerecord.errors.messages.user.unauthorized')
      }, status: :unauthorized
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name role])
  end

  def success_response(data:, model:, includes: '', status: :ok)
    return unless data || model

    if data.respond_to?('each')
      render json: data, each_serializer: "Api::V1::#{model}Serializer".constantize,
             includes: includes.split(','), status: status
    else
      render json: data, serializer: "Api::V1::#{model}Serializer".constantize,
             includes: includes.split(','), status: status
    end
  end

  def error_response(data:)
    return unless data

    render json: data.errors, status: :unprocessable_entity
  end

  def user_not_authorized
    render json: { erros: t('activerecord.errors.messages.pundit.unauthorized') },
           status: :unauthorized
  end
end
