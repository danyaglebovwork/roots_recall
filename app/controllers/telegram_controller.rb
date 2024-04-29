class TelegramController < Telegram::Bot::UpdatesController
  around_action :with_locale

  def start!
    handler = Telegram::Handlers::Start.new(self)
    handler.handle
  end

  def message(message)
    bot = Telegram::Client.new
    if message.voice.present?
      user = User.find_by(telegram_id: message.from.id)
      file_info = bot.get_file(file_id: message.voice.file_id)

      downloaded_file = bot.download_file(file_info.file_path)

      Flashback.create!(
        user_id: user.id,
        title:  file_info.file_unique_id,
        file: downloaded_file
      )
    end

    p message
  end

  def auth
  end

  def callback_query(data)
    handler = Telegram::Handlers::callback_query.new(self)
    handler.handle!(data)
  end

  def new_flashback!
    keyboard  = [
      [
        { text: "да", callback_data: "add_new_flashback" },
        { text: "нет", callback_data: "cancel" }
      ]
    ]

    respond_with :message, text: "Вы хотите создать новое воспоминание?", reply_markup: {
      keyboard: keyboard,
      one_time_keyboard: true,
      resize_keyboard: true
    }
  end

  private

  def with_locale(&block)
    I18n.with_locale(locale_for_update, &block)
  end

  def locale_for_update
    if from

    elsif chat

    end
  end
end
