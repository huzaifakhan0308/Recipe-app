require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before(:each) do
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
                        password_confirmation: '123456', confirmation_token: nil, confirmed_at: Time.now)
    @recipe = Recipe.create(name: 'Test recipe', preparation_time: 10.2, cooking_time: 20.3,
                            description: 'Test description', public: true, users_id: @user.id)
    @food = Food.create(name: 'Test food', price: 12.2, quantity: 4, measurement_unit: 'pce', users_id: @user.id)
    @recipe_food = RecipeFood.create(quantity: 10, recipe_id: @recipe.id, food_id: @food.id)
  end
  it 'is not valid without a quantity' do
    @recipe_food.quantity = nil
    expect(@recipe_food).to_not be_valid
  end
  it 'is not valid with a quantity less than 0' do
    @recipe_food.quantity = -1
    expect(@recipe_food).to_not be_valid
  end
  it 'is not valid with a quantity equal to 0' do
    @recipe_food.quantity = 0
    expect(@recipe_food).to_not be_valid
  end
  it 'is not valid without a recipe' do
    @recipe_food.recipe_id = nil
    expect(@recipe_food).to_not be_valid
  end
  it 'is not valid without a food' do
    @recipe_food.food_id = nil
    expect(@recipe_food).to_not be_valid
  end
end
