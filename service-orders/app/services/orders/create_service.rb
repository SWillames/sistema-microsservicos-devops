module Orders
  class CreateService
    Result = Data.define(:order, :errors) do
      def success?
        errors.empty?
      end
    end

    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params
    end

    def call
      order = Order.new(@params)

      if order.save
        Result.new(order: order, errors: [])
      else
        Result.new(order: order, errors: order.errors.full_messages)
      end
    end
  end
end
