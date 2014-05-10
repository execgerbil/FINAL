class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :bid_price
      t.boolean :is_higher
      t.timestamps
    end
  end
end
