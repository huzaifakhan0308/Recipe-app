class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :recipe_id, uniqueness: { scope: :food_id }
end
