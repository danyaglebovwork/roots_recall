module Telegram
  module Handlers
    class Start < Telegram::ApplicationHandler
      def handle
        if current_owner.blank?
          user = User.create!(
            first_name: from[:first_name],
            last_name: from[:last_name],
            telegram_id: from[:id]
          )
        end

        response = current_owner ? "Hello #{from[:username]}!" : 'Hi there!'

        controller.respond_with :message, text: response
      end
    end
  end
end
