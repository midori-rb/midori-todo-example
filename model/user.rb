class User < Sequel::Model
  plugin :timestamps, create: :created_time
  one_to_many :tasks
end
