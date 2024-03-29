class LandingsController < ApplicationController
  def show
    p 'hello'
    @user = User.new
  end
end
