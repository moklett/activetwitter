# ActiveTwitter initialization

# Twitter configuration should be placed in config/twitter.yml.
# It should have the following format:
#
# user: your_user_name
# password: your_password
# log: <true/false>
#
# (You should probably keep this file out of your version control system, for security reasons)
config_file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'twitter.yml'))
if File.exist?(config_file)
  ::ACTIVE_TWITTER_CONFIG = YAML.load_file(config_file).symbolize_keys
else
  ::ACTIVE_TWITTER_CONFIG = {}
end

if ::ACTIVE_TWITTER_CONFIG[:log] && defined?(RAILS_DEFAULT_LOGGER)
  ActiveResource::Base.logger = RAILS_DEFAULT_LOGGER
end

require 'active_twitter'