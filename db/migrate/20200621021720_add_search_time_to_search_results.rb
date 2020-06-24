class AddSearchTimeToSearchResults < ActiveRecord::Migration[6.0]
  def change
    add_column :search_results, :search_time, :float
  end
end
