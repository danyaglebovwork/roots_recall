module Telegram
  class ApplicationHandler
    attr_reader :controller
    attr_reader :from
    attr_reader :chat

    def initialize(controller)
      @controller = controller
      @from = from.transform_keys(&:to_sym)
      @chat = chat.transform_keys(&:to_sym)
    end

    def current_owner
      @current_owner ||= User.find_by(telegram_id: from[:id])
    end
  end
end
