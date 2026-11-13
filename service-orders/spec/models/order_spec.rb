require "rails_helper"

RSpec.describe Order, type: :model do
  subject(:order) { described_class.new(item_name: "Cadeira Gamer", total_amount: 500.00) }
  describe "status" do
    it "nasce como pending" do
      expect(order.status).to eq("pending")
    end

    it "forca o status para pending mesmo se enviado paid na criacao" do
      order = Order.create(item_name: "Cadeira Gamer", total_amount: 500.00, status: "paid")
      expect(order.status).to eq("pending")
    end

    it "permite avançar o status depois de criado" do
      order.save!

      expect(order.update(status: "paid")).to be true
      expect(order.reload.status).to eq("paid")
    end

    it "rejeita status fora da lista" do
      order.save!

      expect(order.update(status: "refunded")).to be false
      expect(order.errors[:status]).to be_present
    end
  end

  describe "validacoes" do
    it "é valido quando possui item_name e total_amount positivo" do
      expect(order).to be_valid
    end

    it "é invalido sem item_name" do
      order.item_name = nil
      expect(order).not_to be_valid
      expect(order.errors[:item_name]).to include("é obrigatório")
    end

    it "é invalido sem total_amount" do
      order.total_amount = nil
      expect(order).not_to be_valid
      expect(order.errors[:total_amount]).to include("é obrigatório")
    end

    [ 0, -19 ].each do |valor|
      it "e invalido com total_amount igual a #{valor}" do
        order.total_amount = valor

        expect(order).not_to be_valid
        expect(order.errors[:total_amount]).to eq([ "deve ser maior que zero" ])
      end
    end
  end

  describe "constraints do banco" do
    it "rejeita item_name nulo mesmo sem passar pelas validações" do
      order.item_name = nil

      expect { order.save!(validate: false) }.to raise_error(ActiveRecord::NotNullViolation)
    end

    it "rejeita total_amount menor ou igual a zero mesmo sem passar pelas validações" do
      order.total_amount = 0

      expect { order.save!(validate: false) }.to raise_error(ActiveRecord::StatementInvalid)
    end
  end
end
