module Orders
  class CreateService
    attr_reader :params, :order, :errors

    def initialize(params)
      @params = params.to_h.symbolize_keys
      @errors = []
    end

    def call
      payload = params.merge(status: "pending")
      @order = Order.new(payload)

      if @order.save
        true
      else
        @errors = @order.errors.full_messages
        false
      end
    end
  end
end
