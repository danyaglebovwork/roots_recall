class Api::ApplicationController < ApplicationController
  before_action { params.permit! }
end
