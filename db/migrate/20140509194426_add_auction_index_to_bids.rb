class AddAuctionIndexToBids < ActiveRecord::Migration
  def change
    add_reference :bids, :auction, index: true
  end
end
