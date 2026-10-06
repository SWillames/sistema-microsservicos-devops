require 'rails_helper'

RSpec.describe 'Orders API', type: :request do
  describe 'GET /orders' do
    it 'retorna a lista de pedidos com status HTTP 200' do
      Order.create!(item_name: 'Teclado', total_amount: 150.00)
      get '/orders'

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.length).to eq(1)
    end
  end

  describe 'GET /orders/:id' do
    it 'retorna os detalhes do pedido quando encontrado (HTTP 200)' do
      order = Order.create!(item_name: 'Headeset', total_amount: 200.00)
      get "/orders/#{order.id}"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['id']).to eq(order.id)
    end

    it 'retorna erro HTTP 404 quando o pedido não existe' do
      get '/orders/999999'

      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body)
      expect(json['error']).to eq('Pedido não encontrado')
    end
  end

  describe 'POST /orders' do
    it 'cria um novo pedido com sucesso (HTTP 201)' do
      payload = { order: { item_name: 'Mouse', total_amount: 50.00 } }
      post '/orders', params: payload, as: :json

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json['item_name']).to eq('Mouse')
      expect(json['status']).to eq('pending')
    end

    it 'retorna erros de validacao com HTTP 422 quando os dados sao invalidos' do
      payload_invalido = { order: { item_name: '', amount: -10.00 } }
      post '/orders', params: payload_invalido, as: :json

      expect(response).to have_http_status(:unprocessable_content)
      json = JSON.parse(response.body)
      expect(json).to have_key('errors')
    end
  end
end
