Sequel.migration do
  transaction
  change do
    create_table(:tasks) do
      primary_key :id
      String :title, text: true, null: false
      Integer :status, default: 0
      DateTime :created_time, null: false
      foreign_key :user_id, :users, null: false, key: [:id]
    end
  end
end
