class Food < ApplicationRecord
  validates :name, presence: true, length: { maximum: 250 }
  validates :measurement_unit, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :users, class_name: 'User'
  has_many :recipe_foods, foreign_key: 'food_id', dependent: :destroy

  def missing_foods
    select('foods.name', 'SUM(recipe_foods.quantity) AS total_quantity',
           'foods.quantity AS food_quantity', 'foods.price')
      .joins(recipe_foods: :recipe)
      .where(users_id: user.id)
      .group('foods.name, foods.quantity, foods.price')
      .having('SUM(recipe_foods.quantity) > foods.quantity')
  end
end
