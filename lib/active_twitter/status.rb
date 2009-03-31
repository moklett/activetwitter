module ActiveTwitter

  # The Twitter::Status class offers methods to retrieve and interact with Twitter statuses.
  #
  # The following parameters are valid on the collection retrieval methods:
  #
  # +since+::
  #     Narrows the returned results to just those statuses created after the specified HTTP-formatted date,
  #     (e.g. Tue%2C+27+Mar+2007+22%3A55%3A48+GMT) up to 24 hours old.
  # +since_id+::
  #     Returns only statuses with an ID greater than (that is, more recent than) the specified ID.
  #     Ex: http://twitter.com/statuses/friends_timeline.xml?since_id=12345
  # +max_id+::
  #     Returns only statuses with an ID less than (that is, older than) the specified ID.
  #     Ex: http://twitter.com/statuses/friends_timeline.xml?max_id=54321
  # +count+::
  #     Specifies the number of statuses to retrieve. May not be greater than 200. (Twitter limitation)
  #     Ex: http://twitter.com/statuses/friends_timeline.xml?count=5 
  # +page+:: Ex: http://twitter.com/statuses/friends_timeline.rss?page=3
  class Status < Client
    include Restification
    
    self.element_name = "status"
    
    attr_accessor_with_default(:default_scope, :friends) #:nodoc: # TODO
    
    class << self
      def public_timeline(params = nil)
        find(:all, :from => :public_timeline, :params => params)
      end

      # Returns the 20 most recent statuses posted from the authenticating user. It's also possible to request
      # another user's timeline via the id parameter below. This is the equivalent of the Web /archive page for 
      # your own user, or the profile page for a third party.
      #
      # See http://apiwiki.twitter.com/REST+API+Documentation#statuses/usertimeline
      def user_timeline(params = nil)
        find(:all, :from => :user_timeline, :params => params)
      end

      # Returns the 20 most recent statuses posted by the authenticating user and that user's friends.
      # This is the equivalent of /home on the Web. 
      #
      # See http://apiwiki.twitter.com/REST+API+Documentation#statuses/friendstimeline
      def friends_timeline(params = nil)
        find(:all, :from => :user_timeline, :params => params)
      end
    
      def replies(params = nil)
        find(:all, :from => :replies, :params => params)
      end
    end
  end
end