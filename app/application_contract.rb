class ApplicationContract < Dry::Validation::Contract
  config.messages.backend = :i18n
  config.messages.top_namespace = :validations
end
