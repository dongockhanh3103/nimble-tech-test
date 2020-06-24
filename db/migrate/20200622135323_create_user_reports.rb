class CreateUserReports < ActiveRecord::Migration[6.0]
  def up
    create_table :user_reports do |t|
      t.bigint :user_id, null: false
      t.string :report_type, null: false
      t.integer :state, limit: 1, default: 0, null: false
      t.text :criteria
      t.string :file
      t.datetime :finishes_on

      t.timestamps
    end

    add_foreign_key :user_reports, :users, on_delete: :cascade
    add_index :user_reports, [:user_id, :report_type]
  end

  def down
    remove_foreign_key :user_reports, :users
    remove_index :user_reports, name: "index_user_reports_on_user_id_and_report_type"
    drop_table :user_reports
  end
end
