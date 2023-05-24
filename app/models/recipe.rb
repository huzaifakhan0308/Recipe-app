class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :preparation_time, numericality: { greater_then: 0 }
  validates :cooking_time, numericality: { greater_then: 0 }

  belongs_to :users, class_name: 'User'
  has_many :recipe_foods, dependent: :destroy
end
