# Rails.configuration.stripe = {
#   publishable_key: Rails.application.credentials.stripe[:publishable_key],
#   secret_key: Rails.application.credentials.stripe[:secret_key]
# }

# Stripe.api_key = Rails.configuration.stripe[:secret_key]
if Rails.env.development?
  Rails.application.config.stripe = {
    publishable_key: 'pk_test_mocked_key',
    secret_key: 'sk_test_mocked_key'
  }
else
  Rails.application.config.stripe = {
    publishable_key: Rails.application.credentials.dig(:stripe, :publishable_key),
    secret_key: Rails.application.credentials.dig(:stripe, :secret_key)
  }
end
