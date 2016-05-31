require "rails_helper"

RSpec.describe Api::V1::TransactionsController do
  before(:each) do
    @transaction = Transaction.create(invoice_id: 6, credit_card_number: 234324324324, credit_card_expiration_date: 23, result: "success")
    Transaction.create(invoice_id: 10, credit_card_number: 49723483, credit_card_expiration_date: 10, result: "failed")
  end

  describe "Get index" do
    it "shows all transactions" do
      get :index, format: :json

      transactions_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(transactions_hash.first[:invoice_id]).to eq 6
      expect(transactions_hash.first[:credit_card_number]).to eq "234324324324"
      expect(transactions_hash.first[:result]).to eq "success"
      expect(transactions_hash.last[:invoice_id]).to eq 10
      expect(transactions_hash.last[:credit_card_expiration_date]).to eq "10"
      expect(transactions_hash.last[:result]).to eq "failed"
    end
  end

  describe "Get show" do
    it "shows a single transaction" do
      get :show, format: :json, id: @transaction.id

      transaction_hash = JSON.parse(response.body, symbolize_names: true)

      expect(transaction_hash[:invoice_id]).to eq 6
      expect(transaction_hash[:credit_card_expiration_date]).to eq "23"
      expect(transaction_hash[:result]).to eq "success"
    end
  end
end
