module Telegram
  module Handlers
    class CallbackQuery < Telegram::ApplicationHandler
      def handle(data)
        if data == "add_new_flashback"
          respond_with :message, text: "Запишите голосовое"
        elsif data == "cancel"
          respond_with :message, text: "Хорошего дня!"
        else
          respond_with :message, text: "Хорошего дня!"
        end
      end
    end
  end
end
