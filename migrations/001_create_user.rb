Sequel.migration do
  transaction
  change do
    create_table(:users) do
      primary_key :id
      String :username, size: 255, null: false, unique: true
      String :password, text: true, null: false
      DateTime :created_time, null: false
    end
  end
end
