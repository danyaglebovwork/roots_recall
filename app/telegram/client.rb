module Telegram
  class Client
    attr_reader :bot

    def initialize
      @bot = Telegram.bot
      Telegram::Bot::Client.typed_response!
      bot.extend(Telegram::Bot::Client::TypedResponse)
    end

    def get_me
      bot.get_me
    end

    def get_file(file_id)
      bot.get_file(file_id)
    end

    def download_file(file_path)
      token = Rails.application.credentials.telegram.bot
      url = "https://api.telegram.org/file/bot" + token.to_s + "/" + file_path

      io = URI.open(url)
    end
  end
end
