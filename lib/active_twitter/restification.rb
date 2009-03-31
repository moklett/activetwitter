module ActiveTwitter
  # The Twitter API has a non-conventional URL for the find one (or show) action, so this alias chain
  # allows us to use the normal find by id method with the Twitter API.
  #
  #     Twitter::Status.find(1)
  #     # => GET https://twitter.com:443/statuses/show/1.xml
  #
  #     # Find all maps to the user_timeline
  #     Twitter::Status.find(:all)
  #     # => GET https://twitter.com:443/statuses/user_timeline.xml
  #     
  module Restification
    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        class << self
          alias_method_chain :find, :twitter_api_restification
        end
      end
    end
    
    module ClassMethods
      def find_with_twitter_api_restification(*arguments)
        scope   = arguments.slice!(0)
        options = arguments.slice!(0) || {}
  
        case scope
        when String, Integer
          find_without_twitter_api_restification(:one, {:from => "/#{self.element_name.pluralize}/show/#{scope}.#{format.extension}"})
        else
          find_without_twitter_api_restification(scope, options)
        end
      end
    end
  end
end