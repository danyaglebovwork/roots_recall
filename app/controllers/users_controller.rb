class UsersController < ApplicationController
  def show
    authenticate!

    @user = current_owner
  end
end
