class UserToken < Ohm::Model
  attribute :token
  attribute :user_id

  index :token
end
