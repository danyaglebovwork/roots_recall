module Users
  module Handlers
    class Show < ApplicationHandler
      params do
        required(:user_id).filled(:integer)
      end

      def handle
        authorize!

        json { ::Users::Presenters::Show.new(user).as_json }
      end

      private def user
        @user ||= User.find(params[:user_id])
      end

      private def authorize!
        authenticate!

        return if current_user == user
      end
    end
  end
end
