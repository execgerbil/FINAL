class Bid < ActiveRecord::Base
  belongs_to :auction

  validates :bid_price, presence: true, numericality: { only_integer: true }

  scope :ordered_by_creation, -> { order("created_at ASC")}
  
  
end
