class BidsController < ApplicationController

  before_action :find_auction

  def create
    @bid = @auction.bids.new(bid_params)
    if @bid.bid_price > @auction.current_price
      price_update
      reserve_met
      @bid.save
      redirect_to @auction, notice: "Bid registered!"
    else
      flash.now[:alert] = "Bid didn't register - please try again"
      render "auctions/show"
    end
  end

  def update
    @bid = Bid.find(params[:id])
    if @bid.update_attributes(bid_params)
      render nothing: true
    else
      render nothing: true
    end
  end

  def find_auction
    @auction = Auction.find params[:auction_id]
  end

  def bid_params
    params.require(:bid).permit(:bid_price, :is_higher)
  end

  def price_update
    @auction.current_price = @bid.bid_price + 1
    @auction.save
  end

  def reserve_met
    if @auction.current_price >= @auction.reserve_price
      @auction.complete
    else
      @auction.publish
    end
  end

end

