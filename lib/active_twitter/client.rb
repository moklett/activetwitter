module ActiveTwitter
  # The ActiveTwitter::Client class defines the interface to the Twitter API via ActiveResource.  Refer to
  # the subclasses of ActiveTwitter::Client for the good stuff:
  #
  # ActiveTwitter::Status
  # ActiveTwitter::User
  #
  class Client < ActiveResource::Base
    self.site = "https://twitter.com"
    self.user = ACTIVE_TWITTER_CONFIG[:user]
    self.password = ACTIVE_TWITTER_CONFIG[:password]

    class Error < StandardError
    end
  end
end
