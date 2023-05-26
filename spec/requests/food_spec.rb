require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  before(:each) do
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
                        password_confirmation: '123456', confirmation_token: nil, confirmed_at: Time.now)
    @recipe = Recipe.create(name: 'Test recipe', preparation_time: 10.2, cooking_time: 20.3,
                            description: 'Test description', public: true, users_id: @user.id)
    @food = Food.create(name: 'Test food', price: 12.2, quantity: 4, measurement_unit: 'pce', users_id: @user.id)
    @food_two = Food.create(name: 'Test food two', price: 12.2, quantity: 4, measurement_unit: 'pce',
                            users_id: @user.id)
    @recipe_food = RecipeFood.create(quantity: 10, recipe_id: @recipe.id, food_id: @food.id)
    post user_session_path params: { user: { email: @user.email, password: @user.password } }
  end
  describe ' GET /foods/new' do
    it 'return http success' do
      get new_food_path
      expect(response).to have_http_status(200)
    end
    it ' render the new template' do
      get new_food_path
      expect(response).to render_template('new').or(render_template('foods/new'))
    end
    it 'displays the new food form' do
      get new_food_path
      expect(response.body).to include('Create New Food')
    end
  end
  describe 'GET /general_shopping_list' do
    it 'return http success' do
      get general_shopping_lists_path
      expect(response).to have_http_status(200)
    end
    it 'render the index template' do
      get general_shopping_lists_path
      expect(response).to render_template('index').or(render_template('general_shopping_lists'))
    end
  end
end
