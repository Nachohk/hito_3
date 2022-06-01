class AddUserToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :user_id, :integer, index: true
    add_reference :posts, :users, index:true
    add_foreign_key :posts, :users
  end
end
