class TelegramController < Telegram::Bot::UpdatesController
  around_action :with_locale

  def message(message)
    p message
  end

  def auth
  end

  def new_flashback!
    kb = [
        [{ text: '', callback_data: 'https://google.com' },
        { text: 'Touch me', callback_data: 'touch' },
        { text: 'Switch to inline', callback_data: 'some text' }]
    ]

    respond_with :message, text: "Вы хотите создать новое воспоминание?", reply_markup: {
      keyboard: kb,
      one_time_keyboard: true,
      resize_keyboard: true
    }
  end

  def start!(word = nil, *other_words)
    user = User.find_by(id: from[:id])

    if user.blank?
      user = User.create!(
        first_name: from[:first_name],
        last_name: from[:last_name],
        telegram_id: from[:id]
      )
    end

    response = from ? "Hello #{from['username']}!" : 'Hi there!'

    respond_with :message, text: response
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
