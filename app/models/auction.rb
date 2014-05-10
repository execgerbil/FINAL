class Auction < ActiveRecord::Base
  has_many :bids, dependent: :destroy

  validates :title, presence: true
  
  scope :published, -> { where(state: :published) }

  state_machine :state, initial: :draft do

    event :publish do
      transition draft: :published
    end

    event :complete do
      transition published: :reserve_met
    end

    event :won do
      transition reserve_met: :won
    end

    event :canceled do
      transition [:draft, :published, :reserve_met] => :canceled
    end

    event :reserve_not_met do
      transition published: :canceled
    end

  end
end
