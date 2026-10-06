require 'rails_helper'

RSpec.describe Orders::CreateService, type: :service do
  describe '#call' do
    context 'quando os parametros sao validos' do
      it 'cria o pedido na base de dados com status pending' do
        params = { item_name: 'Cadeira Gamer', total_amount: 800.00}
        service = described_class.new(params)

        expect(service.call).to be true
        expect(service.order).to be_persisted
        expect(service.order.status).to eq('pending')
      end

      it 'forca o status para pending mesmo se enviado status paid nos parametros' do
        params = { item_name: 'Cadeira Gamer', total_amount: 800.00, status: 'paid' }
        service = described_class.new(params)

        expect(service.call).to be true
        expect(service.order.status).to eq('pending')
      end
    end

    context 'quando os parametros sao invalidos' do
      it 'nao cria o pedido e retorna a lista de erros' do
        params = { item_name: '', total_amount: -100.00 }
        service = described_class.new(params)

        expect(service.call).to be false
        expect(service.order).not_to be_persisted
        expect(service.errors).not_to be_empty
      end
    end
  end
end