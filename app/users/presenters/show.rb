module Users
  module Presenters
    class Show
      attr_reader :user

      def initialize(user)
        @user = user
      end

      def as_json(options: nil)
        {
          id: user.id,
          first_name: user.first_name,
          last_name: user.last_name,
          father_name: user.father_name,
          email: user.email
        }
      end
    end
  end
end
