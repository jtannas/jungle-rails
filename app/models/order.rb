class Order < ActiveRecord::Base
  before_create :ensure_sufficient_inventory
  after_create :allocate_product_inventory

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  private
    def ensure_sufficient_inventory
      self.line_items.each do |line_item|
        if line_item.product.quantity < line_item.quantity
          return false
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
