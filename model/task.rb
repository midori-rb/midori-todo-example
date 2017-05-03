class Task < Sequel::Model
  plugin :timestamps, create: :created_time
  many_to_one :user
end
