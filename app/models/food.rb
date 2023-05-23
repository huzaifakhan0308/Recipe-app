class Food < ApplicationRecord
  validates :name, presence: true, length: { maximum: 250 }
  validates :measurement_unit, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :users, class_name: 'User'
  has_many :recipe_foods, foreign_key: 'foods_id', dependent: :destroy
end
