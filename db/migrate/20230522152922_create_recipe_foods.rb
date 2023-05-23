# frozen_string_literal: true

class CreateRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_foods do |t|
      t.integer :quality, default: 0
      t.references :recipes, null: false, foreign_key: true
      t.references :foods, null: false, foreign_key: true

      t.timestamps
    end
  end
end
