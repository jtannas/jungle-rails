class Order < ActiveRecord::Base

  # Callbacks
  before_create :ensure_sufficient_inventory
  after_create :allocate_product_inventory

  # Associations
  belongs_to :user
  has_many :line_items

  # Formats
  monetize :total_cents, numericality: true

  # Validations
  validates :stripe_charge_id, presence: true

  # Helpers
  private
    def ensure_sufficient_inventory
      self.line_items.each do |line_item|
        if line_item.product.quantity < line_item.quantity
          return false  # Cancel Save
        end
      end
    end

    def allocate_product_inventory
      self.line_items.each do |line_item|
        line_item.product.quantity -= line_item.quantity
        line_item.product.save
      end
    end
end
