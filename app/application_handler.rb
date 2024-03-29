class ApplicationHandler
  class Renderer
    def initialize(handler, status: 200)
      @handler = handler
      @status = status
      @formats = {}
    end

    def render
      result = { status: @status }

      if @formats.has_key?(:json)
        result[:json] = @handler.instance_eval(&@formats[:json])
      end

      result
    end

    def json(&block)
      @formats[:json] = block if block_given?
    end
  end

  attr_reader :controller
  attr_reader :params
  attr_reader :payload
  attr_reader :errors

  def initialize(controller)
    @errors = []

    if self.class.params.present?
      result = self.class.params.call(controller.params.to_h)

      if result.failure?
        @errors << result.errors(full: true).to_h
      end

      @params = result.to_h
    end

    if self.class.payload.present?
      result = self.class.payload.call(controller.params.to_h)

      if result.failure?
        @errors << result.errors(full: true).to_h
      end

      @payload = result.to_h
    end

    @controller = controller
  end

  def self.payload(&block)
    if block_given?
      klass = Class.new(ApplicationContract) do
        json(&block)
      end

      @payload_contract = klass.new
    end

    @payload_contract
  end

  def handle!
    if @errors.present?
      render status: 422 do
        json { @errors }
      end

      return
    end

    handle
  end

  def handle
    render status: 204
  end

  def self.params(&block)
    if block_given?
      klass = Class.new(ApplicationContract) do
        params(&block)
      end

      @params_contract = klass.new
    end

    @params_contract
  end

  protected def render(status: 200, &block)
    unless block_given?
      @controller.render status: status
      return
    end

    renderer = ApplicationHandler::Renderer.new(self, status: status)
    renderer.instance_eval(&block) if block_given?

    @controller.render renderer.render
  end

  protected def authenticate!
    access_denied!(message: "Нет доступа!") unless authenticated?
  end

  protected def authenticated?
    current_session.present?
  end

  protected def access_denied!(message: nil)
    raise Errors::AccessDenied, message || "Нет доступа!"
  end

  protected def current_session
    @current_session ||= controller.session
  end

  protected def current_owner
    @current_owner ||= User.find_by(id: current_session[:user_id])
  end

  protected def params
    controller.params
  end

  protected def headers
    controller.headers
  end

  protected def redirect_to(url, allow_other_host: false)
    controller.redirect_to(url, allow_other_host: allow_other_host)
  end
end
