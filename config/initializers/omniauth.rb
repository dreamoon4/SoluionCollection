Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
    Rails.application.secrets.GOOGLE_CLIENT_ID,
    Rails.application.secrets.GOOGLE_CLIENT_SECRET,
    {
      :scope => 'email'
    }
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
