class Review < ActiveRecord::Base
  #Associations
  belongs_to :user
  belongs_to :product

  # Validators
  validates :rating, presence: true, numericality: true, :inclusion => { :in => 1..5 }
  validates :user_id, presence: true
  validates :product_id, presence: true
end
