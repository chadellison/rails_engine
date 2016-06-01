require "rails_helper"

RSpec.describe Api::V1::TransactionsController do
  before(:each) do
    @transaction = Transaction.create(invoice_id: 6, credit_card_number: "234324324324", credit_card_expiration_date: "23", result: "success")
    Transaction.create(invoice_id: 10, credit_card_number: "49723483", credit_card_expiration_date: "10", result: "failed")
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

  describe "Get random" do
    it "returns a random transaction" do
      get :random, format: :json

      transaction_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      assert transaction_hash[:invoice_id]
      assert transaction_hash[:credit_card_number]
      assert transaction_hash[:result] 
    end
  end

  describe "Get find shows all transactions according to a search criterion" do
    it "works for invoice_id" do
      get :find, invoice_id: 6, format: :json
      transaction_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(transaction_hash[:invoice_id]).to eq 6
      expect(transaction_hash[:credit_card_number]).to eq  "234324324324"
    end

    it "works for created_at" do
      yesterday = Date.today - 1
      @transaction.update(created_at: yesterday)

      get :find, created_at: yesterday, format: :json
      transaction_hash = JSON.parse(response.body, symbolize_names: true)
      expect(transaction_hash[:invoice_id]).to eq 6
      expect(transaction_hash[:credit_card_number]).to eq  "234324324324"
    end

    it "works for an id" do
      get :find, id: @transaction.id, format: :json
      transaction_hash = JSON.parse(response.body, symbolize_names: true)
      expect(transaction_hash[:invoice_id]).to eq 6
      expect(transaction_hash[:credit_card_number]).to eq  "234324324324"
    end

    it "works for updated_at" do
      yesterday = Date.today - 1
      @transaction.update(updated_at: yesterday)

      get :find, updated_at: yesterday, format: :json
      transaction_hash = JSON.parse(response.body, symbolize_names: true)
      expect(transaction_hash[:invoice_id]).to eq 6
      expect(transaction_hash[:credit_card_number]).to eq  "234324324324"
    end

    it "works for unit_price" do
      get :find, result: "success", format: :json
      transaction_hash = JSON.parse(response.body, symbolize_names: true)
      expect(transaction_hash[:invoice_id]).to eq 6
      expect(transaction_hash[:credit_card_number]).to eq  "234324324324"
    end

    it "works for credit_card_number" do
      get :find, credit_card_number: "234324324324", format: :json
      transaction_hash = JSON.parse(response.body, symbolize_names: true)
      expect(transaction_hash[:invoice_id]).to eq 6
      expect(transaction_hash[:credit_card_number]).to eq "234324324324"
    end

    it "works for expiration_date" do
      get :find, credit_card_expiration_date: "23", format: :json
      transaction_hash = JSON.parse(response.body, symbolize_names: true)
      expect(transaction_hash[:invoice_id]).to eq 6
      expect(transaction_hash[:credit_card_number]).to eq "234324324324"
    end
  end

  describe "Get find_all finds all transactions according to a search criterion" do
    it "works for invoice_id" do

      get :find_all, invoice_id: 6, format: :json
      transactions_hash = JSON.parse(response.body, symbolize_names: true)
      expect(transactions_hash.map do |transaction|
        transaction[:invoice_id]
      end).to eq [6]
      expect(transactions_hash.map do |transaction|
        transaction[:credit_card_number]
      end).to eq ["234324324324"]
    end

    it "works for created_at" do
      today = Date.today
      Transaction.create(invoice_id: 6, created_at: today)
      Transaction.create(invoice_id: 10, created_at: today)
      Transaction.create(invoice_id: 11, created_at: today)

      get :find_all, created_at: Date.today, format: :json

      merchants_hash = JSON.parse(response.body, symbolize_names: true)
      expect(merchants_hash.map do |transaction|
        transaction[:invoice_id]
      end).to eq [6, 10, 11]
      expect(merchants_hash.count).to eq 3
    end

    it "works for id" do
      get :find_all, id: @transaction.id, format: :json
      transactions_hash = JSON.parse(response.body, symbolize_names: true)
      expect(transactions_hash.map do |transaction|
        transaction[:invoice_id]
      end).to eq [6]

      expect(transactions_hash.map do |transaction|
        transaction[:credit_card_number]
      end).to eq ["234324324324"]
    end

    it "works for updated_at" do
      @transaction.update(updated_at: Date.today)

      get :find_all, updated_at: Date.today, format: :json
      transactions_hash = JSON.parse(response.body, symbolize_names: true)
      expect(transactions_hash.map do |transaction|
        transaction[:invoice_id]
      end).to eq [6]
    end

    it "works for result" do
      Transaction.create(result: "success", invoice_id: 9600)
      get :find_all, result: "success", format: :json
      transactions_hash = JSON.parse(response.body, symbolize_names: true)
      expect(transactions_hash.map do |transaction|
        transaction[:invoice_id]
      end).to eq [6, 9600]
    end

    it "credit_card_number" do
      get :find_all, credit_card_number: "234324324324", format: :json
      transactions_hash = JSON.parse(response.body, symbolize_names: true)
      expect(transactions_hash.map do |transaction|
        transaction[:invoice_id]
      end).to eq [6]
    end

    it "works for credit_card_expiration_date" do
      get :find_all, credit_card_expiration_date: 10, format: :json
      transactions_hash = JSON.parse(response.body, symbolize_names: true)
      expect(transactions_hash.map do |transaction|
        transaction[:invoice_id]
      end).to eq [10]
    end
  end
end
