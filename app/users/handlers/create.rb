module Users
  module Handlers
    class Create < ApplicationHandler
      payload do
        required(:user).hash do
          required(:first_name).filled(:string)
          required(:last_name).filled(:string)
          required(:father_name).filled(:string)
          required(:email).filled(:string)
          required(:password).filled(:string)
          required(:confirmation_password).filled(:string)
        end
      end

      def handle
        if payload[:user][:password] != payload[:user][:confirmation_password]
          render status: 422 do
            json { Errors::Error.alert("Пароль не совпадает с подтверждение") }
          end

          return
        end

        user = User.create!(
          first_name: payload[:user][:first_name],
          last_name: payload[:user][:last_name],
          father_name: payload[:user][:father_name],
          email: payload[:user][:email],
          password: payload[:user][:password]
        )

        controller.session[:user_id] = user.id

        render status: 200 do
          json { ::Users::Presenters::Show.new(user).as_json }
        end
      end
    end
  end
end
