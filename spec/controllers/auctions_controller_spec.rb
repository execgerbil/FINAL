require "spec_helper"

describe AuctionsController do 
  let(:auction) { create(:auction) }

  describe "#index" do

    it "makes an instance of auction in auctions" do
      auction
      get :index
      expect(assigns(:auctions)).to include auction
    end
  end

  describe "#new" do

    it "assigns a new auction an instance variable" do
      get :new
      expect(assigns(:auction)).to be
    end
  end

  describe "#create" do

  context "with valid parameters" do

    def valid_request
       post :create, auction: {title: "valid auction title", details: "valid auction details"}
    end

    it "creates a new auction in the database" do
      expect { valid_request }.to change {Auction.count}.by(1)
    end

    it "redirects to the show page after creating a new auction" do
      valid_request
      expect(response).to redirect_to(Auction.last)
    end
  end
   context "with invalid parameters" do

    def invalid_request
    post :create, auction: {title: "", details: "valid auction details"}
    end

    it "doesn't create an auction in the database" do
      expect { invalid_request }.to_not change { Auction.count }
    end

    it "renders the new template" do
      invalid_request
      expect(response).to render_template(:new)
    end
  end
  end

  describe "#edit" do
    it "assigns an instance variable and auction, auction id is passed" do
      get :edit, id: auction.id
      expect(assigns(:auction)).to eq(auction)
    end

  end

  describe "#show" do
    it "assigns an instance variable and auction, auction id is passed" do
      get :show, id: auction.id
      expect(assigns(:auction)).to eq(auction)
    end
  end

  describe "#update" do

  context "with valid params" do
    def valid_request
       patch :update, id: auction.id, auction: {title: "New auction title"}
    end

    it "updates the title to the new one" do
      valid_request
      auction.reload
      expect(auction.title).to eq("New auction title")
    end

    it "redirects to the auction show page" do
      valid_request
      expect(response).to redirect_to(auction)
    end

  context "with invalid params" do
    def invalid_request
      patch :update, id: auction.id, auction: {title: ""}
    end

    it "doesn't update the auction title" do
      old_title = auction.title
      invalid_request
      auction.reload
      expect(auction.title).to eq(old_title)
    end

    it "renders the edit template on the chosen auction" do
      invalid_request
      expect(response).to render_template(:edit)
    end
  end

  describe "#destroy" do

    it "removes the auction from the database" do
      auction
      expect { delete :destroy, id: auction.id}.to change {Auction.count}.by(-1)
    end

    it "redirects to the all auctions listing page" do
      auction
      delete :destroy, id: auction.id
      expect(response).to redirect_to(auctions_path)
    end

  end

end
end
end