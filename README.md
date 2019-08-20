# OmniAuth Eventpop

Eventpop OAuth2 Strategy for OmniAuth.

### Installing

Add to your `Gemfile`:

```ruby
gem 'omniauth-eventpop', github: 'eventpop/omniauth-eventpop'
```

Then `bundle install`.

### Usage

`OmniAuth::Strategies::Eventpop` is simply a Rack middleware. Read the OmniAuth docs for detailed instructions: https://github.com/intridea/omniauth.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :eventpop, ENV['EVENTPOP_APP_ID'], ENV['EVENTPOP_APP_SECRET']
end
```

### Auth Hash

Here's an example *Auth Hash* available in `request.env['omniauth.auth']`:

```ruby
{
  provider: 'eventpop',
  uid: '1234567',
  info: {
    email: 'joe@bloggs.com',
    full_name: 'Joe Bloggs'
  },
  credentials: {
    token: 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
    expires_at: 1321747205, # when the access token expires (it always will)
    expires: true # this will always be true
  },
  extra: {
    raw_info: {
      id: '1234567',
      full_name: 'Joe Bloggs',
      email: 'joe@bloggs.com',
      # ...
    }
  }
}
```

