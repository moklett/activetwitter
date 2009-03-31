module ActiveTwitter
  class User < Client
    include Restification
    
    class << self
      def followers(params = nil)
        find(:all, :from => "/statuses/followers.#{format.extension}", :params => params)
      end
      
      def follower_ids(params = nil)
        list = find(:one, :from => "/followers/ids.#{format.extension}", :params => params).id
        list.collect { |id| id.to_i }
      end
    end
    
    def followers(params = {})
      self.class.followers(params.merge(id_params))
    end
    
    def follower_ids(params = {})
      self.class.follower_ids(params.merge(id_params))
    end
    
    private
    def id_params
      if id
        {:user_id => id}
      elsif screen_name
        {:screen_name => screen_name}
      else
        {}
      end
    end
      
  end
end