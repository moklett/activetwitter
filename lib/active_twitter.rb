# For non-Rails uses
require 'rubygems'
require 'activeresource'

# ActiveTwitter classes
require 'active_twitter/client'
require 'active_twitter/status'
require 'active_twitter/user'

# ActiveTwitter is a ruby Twitter (http://www.twitter.com) client based on ActiveResource.  It exposes a
# RESTful interface to the Twitter API, while also adding useful methods for accessing core Twitter features
# in a concise way.
module ActiveTwitter
  MAX_FETCH_COUNT = 200
  
  class << self
    # The #tweets method is a shortcut for grabbing Statuses (tweets) from Twitter.  This is probably
    # what we'll want to do the most, so let's make it easy.
    #
    # Calling #tweets with no arguments gets the 20 most recent tweets for the authenticated user and
    # their friends... just like the /home page on Twitter.
    # 
    #     ActiveTwitter.tweets
    def tweets(*arguments)
      scope   = arguments.slice!(0)
      options = arguments.slice!(0) || {}
    
      case scope # :mine, :all, :public, nil
      when :mine
        Status.user_timeline(options)
      when :public
        Status.public_timeline(options)
      else # :all, :friends, nil
        Status.friends_timeline(options)
      end
    end
    
    def replies(params = nil)
      Status.replies(params)
    end
    
    def me
      User.find(Client.user)
    end
    alias_method :my, :me
    
    def followers(params = nil)
      User.followers(params)
    end
    
  end
end
  