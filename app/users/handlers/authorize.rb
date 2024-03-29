module Users
  module Handlers
    class Authorize < ApplicationHandler
      payload do
        required(:user).hash do
          required(:email).filled(:string)
          required(:password).filled(:string)
        end
      end

      def handle
        user = User.find_by(email: payload[:user][:email])

        if !user.authenticate(payload[:user][:password])
          render status: 422 do
            json { Errors::Error.alert("Не верный пароль") }
          end

          return
        end

        controller.session[:user_id] = user.id

        redirect_to "/users/#{user.id}"
      end
    end
  end
end
