module Api
  class UsersController < Api::ApplicationController
    def index
      handler = Users::Handlers::Index.new(self)
      handler.handle!
    end

    def show
      handler = Users::Handlers::Show.new(self)
      handler.handle!
    end

    def create
      handler = Users::Handlers::Create.new(self)
      handler.handle!
    end

    def update
      handler = Users::Handlers::Update.new(self)
      handler.handle!
    end

    def destroy
      handler = Users::Handlers::Destroy.new(self)
      handler.handle!
    end

    def authorize
      handler = Users::Handlers::Authorize.new(self)
      handler.handle!
    end
  end
end
