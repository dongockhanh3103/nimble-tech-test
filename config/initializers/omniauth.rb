client_id = Settings.google.client_id
client_secret = Settings.google.client_secret

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, client_id, client_secret,
  {
    scope: [
      'email',
      'https://www.googleapis.com/auth/gmail.readonly',
      'https://www.googleapis.com/auth/drive.file'
    ],
    access_type: 'offline',
    prompt: 'consent'
  }
end