class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :title
      t.text :details
      t.datetime :ends_on
      t.integer :reserve_price
      t.boolean :is_higher

      t.timestamps
    end
  end
end
