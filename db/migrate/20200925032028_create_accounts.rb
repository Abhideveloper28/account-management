class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :account_type
      t.datetime :open_date
      t.integer :customer_id
      t.string :customer_name
      t.string :branch
      t.boolean :minor_indicator

      t.timestamps
    end
  end
end
