require 'rails_helper'

RSpec.describe "TransactionTypes", type: :request do
  describe "GET /transaction_types" do
    it "works! (now write some real specs)" do
      get transaction_types_path
      expect(response).to have_http_status(200)
    end
  end
end
