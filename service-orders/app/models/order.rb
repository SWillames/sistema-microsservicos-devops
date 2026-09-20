class Order < ApplicationRecord
  STATUSES = %w[pending processing paid failed].freeze

  attribute :status, :string, default: "pending"

  validates :item_name, presence: { message: "é obrigatório" }

  validates :total_amount,
            presence: { message: "é obrigatório" },
            numericality: {
              greater_than: 0, message: "deve ser maior que zero"
            }

  validates :status,
            presence: true,
            inclusion: { in: STATUSES }
end
