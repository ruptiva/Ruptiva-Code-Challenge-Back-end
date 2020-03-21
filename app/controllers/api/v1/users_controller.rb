# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :load_users, only: :index
      before_action :load_user, only: %i[show update destroy]

      def index
        success_response(data: @users, model: 'User')
      end

      def show
        success_response(data: @user, model: 'User')
      end

      def update
        if @user.update(user_params)
          success_response(data: @user, model: 'User')
        else
          error_response(data: @user)
        end
      end

      def destroy
        @user.destroy
        head :no_content
      end

      private

      def load_users
        @users = User.all
      end

      def load_user
        @user = User.find(params.dig(:id))
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name)
      end
    end
  end
end
