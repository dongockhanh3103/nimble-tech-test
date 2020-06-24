class CreateSearchResults < ActiveRecord::Migration[6.0]
  def change
    create_table :search_results do |t|
      t.string :keyword, null: false
      t.float :total_ad_word, default: 0
      t.float :total_link, default: 0
      t.float :total_result, default: 0
      t.string :html_content
      
      t.timestamps
    end
  end
end
