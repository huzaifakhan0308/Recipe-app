class RecipeFood < ApplicationRecord
  belongs_to :recipes, class_name: 'Recipe'
  belongs_to :foods, class_name: 'Food'
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :foods, uniqueness: { scope: :recipes_id }
end
