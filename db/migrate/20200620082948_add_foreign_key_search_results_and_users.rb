class AddForeignKeySearchResultsAndUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :search_results, :user_id, :bigint
    add_foreign_key :search_results, :users
  end
end
