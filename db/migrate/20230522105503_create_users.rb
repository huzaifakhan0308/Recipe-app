# frozen_string_literal: true


# Migration for creating the users table

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :name

      t.timestamps
    end
  end
end
