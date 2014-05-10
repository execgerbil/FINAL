class AuctionsController < ApplicationController

  before_action :find_auction, only: [:edit, :show, :update, :destroy]

  def index
    @auctions = Auction.all
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new(auction_params)
    if @auction.save
      redirect_to @auction, notice: "Auction created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @auction.update_attributes(auction_params)
      redirect_to @auction, notice: "Auction successfully updated"
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @auction.destroy
    redirect_to auctions_path, notice: "Auction successfully deleted"
  end

  def auction_params
    params.require(:auction).permit(:title, :details, :ends_on, :reserve_price, :current_price)
  end

  def find_auction
    @auction = Auction.find(params[:id])
  end

 def publish
  @auction = Auction.find(params[:id])
    if @auction.publish
      redirect_to auctions_path, notice: "Auction published successfully."
    else
      redirect_to auctions_path, alert: "Auction publishing failed"
    end
  end

  


end
