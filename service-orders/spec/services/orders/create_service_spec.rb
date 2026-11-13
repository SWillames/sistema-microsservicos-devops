require "rails_helper"

RSpec.describe Orders::CreateService do
  describe ".call" do
    context "com parametros válidos" do
      it "cria o pedido na base de dados com status pending" do
        service = described_class.call(item_name: "Cadeira Gamer", total_amount: 800.00)

        expect(service).to be_success
        expect(service.order).to be_persisted
        expect(service.order.status).to eq("pending")
        expect(service.errors).to be_empty
      end

      it "forca o status para pending mesmo se enviado status paid nos parametros" do
        service = described_class.call(item_name: "Cadeira Gamer", total_amount: 800.00, status: "paid")
        expect(service).to be_success
        expect(service.order.status).to eq("pending")
      end
    end

    context "com parametros sao invalidos" do
      it "nao cria o pedido e retorna a lista de erros" do
        service = described_class.call(item_name: "", total_amount: -100.00)

        expect(service).not_to be_success
        expect(service.order).not_to be_persisted
        expect(service.errors).to include(
          a_string_including("é obrigatório"),
          a_string_including("deve ser maior que zero")
        )
      end
    end
  end
end
