require "spec_helper"

describe BidsController do
  let (:auction) { create(:auction) }

  describe "#create" do

    context "with valid request" do
      def valid_request
        post :create, auction_id: auction.id, bid: {bid_price: "105"}
      end

      it "creates a bid on the auction" do
        expect { valid_request }.to change { auction.bids.count }.by(1)
      end

      it "associates the bid to the auction" do
        valid_request
        expect(Bid.last.auction).to eq(auction)
      end

      it "redirects to the auction show page" do
        valid_request
        expect(response).to redirect_to(auction)
      end
    end

    context "with invalid request" do
      def invalid_request
        post :create, auction_id: auction.id, bid: {bid_price: ""}
      end

      it "doesn't create a bid in the database" do
        expect { invalid_request }.to_not change { Bid.count }
      end

      it "sets flash alert" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

  # describe "#update" do
  #   let(:bid) { create(:bid, auction: auction) }

  #   it "updates the changed value in the database" do
  #     patch :update, auction_id: auction.id, id: bid.id, bid: {bid_price: "105"}
  #     expect(bid.reload.bid_price).to eq(105)
  #   end


  end


  
end

