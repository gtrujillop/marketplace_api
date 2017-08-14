# Establish a connection between Resque and Redis
if Rails.env == "production"
  uri = URI.parse ENV["REDISCLOUD_URL"]
  Resque.redis = Redis.new host:uri.host, port:uri.port, password:uri.password
else
  Resque.redis = 'localhost:6379'
  Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }
end
