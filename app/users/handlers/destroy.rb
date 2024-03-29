module Users
  module Handlers
    class Destroy < ApplicationHandler
      params do
        required(:user_id).filled(:integer)
      end

      def handle
        user = User.find_by(id: params[:user_id])
        user.destroy!

        render json: {}
      end
    end
  end
end
