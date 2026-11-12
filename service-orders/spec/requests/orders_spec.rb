require "rails_helper"

RSpec.describe "Orders API", type: :request do
  describe "GET /orders" do
    it "retorna lista vazia quando não há pedidos" do
      get "/orders"

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).to eq([])
    end
    it "retorna os pedidos em ordem de criação" do
      primeiro = Order.create!(item_name: "Teclado", total_amount: 150.00)
      segundo = Order.create!(item_name: "Mouse", total_amount: 50.00)

      get "/orders"

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.map { |pedido| pedido["id"] }).to eq([ primeiro.id, segundo.id ])
    end
  end

  describe "GET /orders/:id" do
    it "retorna os detalhes do pedido quando encontrado)" do
      order = Order.create!(item_name: "Headset", total_amount: 200.00)
      get "/orders/#{order.id}"

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).to include("id" => order.id, "item_name" => "Headset")
    end

    it "retorna 404 quando o pedido não existe" do
      get "/orders/999999"

      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body["error"]).to eq("Pedido não encontrado")
    end
  end

  describe "POST /orders" do
    it "cria um novo pedido com sucesso (HTTP 201)" do
      payload = { order: { item_name: "Mouse", total_amount: 50.00 } }

      expect { post "/orders", params: payload, as: :json }.to change(Order, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(response.parsed_body).to include("item_name" => "Mouse", "status" => "pending")
    end

    it "ignora o status enviado pelo cliente" do
      payload = { order: { item_name: "Mouse", total_amount: 50.00, status: "paid" } }

      post "/orders", params: payload, as: :json

      expect(response).to have_http_status(:created)
      expect(response.parsed_body["status"]).to eq("pending")
    end

    it "responde 422 com os erros quando os dados sao invalidos" do
      payload_invalido = { order: { item_name: "", total_amount: -10.00 } }

      expect { post "/orders", params: payload_invalido, as: :json }.not_to change(Order, :count)
      puts response.parsed_body

      expect(response).to have_http_status(:unprocessable_content)
      expect(response.parsed_body["errors"]).to include(
        a_string_including("é obrigatório"),
        a_string_including("deve ser maior que zero")
      )
    end

    it "responde 400 quando o corpo não traz o parametro order" do
      post "/orders", params: { foo: "bar" }, as: :json

      expect(response).to have_http_status(:bad_request)
      expect(response.parsed_body["error"]).to include("order")
    end
  end
end
