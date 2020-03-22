# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate_user
      before_action :load_user, only: :create

      def create
        if valid_pass?
          response.set_header('Authorization', @user.authentication_token)
          session_response
        else
          error_response
        end
      end

      private

      def load_user
        @user = User.find_by(email: params.dig(:user, :email))
      end

      def valid_pass?
        @user&.valid_password?(params.dig(:user, :password))
      end

      def session_response
        success_response(data: @user, model: 'Session')
      end

      def error_response
        render json: {
          errors: t('activerecord.errors.messages.user.invalid_session')
        }, status: :unprocessable_entity
      end
    end
  end
end
