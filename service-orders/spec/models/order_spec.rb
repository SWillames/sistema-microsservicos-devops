require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'atribuicao de atributos padrao' do
    it 'define o status inicial como pending automaticamente' do
      order = Order.new(item_name: 'Cadeira Gamer', total_amount: 500.00)
      expect(order.status).to eq('pending')
    end

    it 'forca o status para pending mesmo se enviado paid na criacao' do
      order = Order.create(item_name: 'Cadeira Gamer', total_amount: 500.00, status: 'paid')
      expect(order.status).to eq('pending')
    end
  end

  context 'validacoes' do
    it 'é valido quando possui item_name e total_amount positivo' do
      order = Order.new(item_name: 'Cadeira Gamer', total_amount: 500.00)
      expect(order).to be_valid
    end

    it 'é invalido sem item_name' do
      order = Order.new(item_name: nil, total_amount: 150.00)
      expect(order).not_to be_valid
      expect(order.errors[:item_name]).to include("é obrigatório")
    end

    it 'e invalido com amount menor ou igual a zero' do
      order_negativo = Order.new(item_name: 'Mouse', total_amount: -19)
      expect(order_negativo).not_to be_valid
    end
  end
end
