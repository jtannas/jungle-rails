class Product < ActiveRecord::Base

  # Formats
  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  # Associations
  belongs_to :category
  has_many :reviews

  # Validators
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category_id, presence: true
end
