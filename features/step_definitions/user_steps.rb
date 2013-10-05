def oauth_credentials(provider = :twitter, mock_options = nil)
  if mock_options == :invalid_credentials
    OmniAuth.config.mock_auth[provider] = :invalid_credentials
  elsif mock_options
    OmniAuth.config.add_mock provider, mock_options
  end
  request.env['omniauth.auth'] = OmniAuth.config.mock_auth[provider]
end

def login_as_user(provider = :twitter)
  oauth_credentials(provider)
  visit "/auth/#{provider}/callback"
end