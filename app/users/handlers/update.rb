module Users
  module Handlers
    class Create < ApplicationHandler
      def handle
        user = User.create!(payload)

        json { ::Users::Presenters::Show.new(user).as_json }
      end

      private def payload
        params.permit(:name, :last_name, :email, :father_name)
      end
    end
  end
end
