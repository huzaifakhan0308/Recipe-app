require 'rails_helper'

RSpec.describe 'Recipes', type: :feature do
  before(:each) do
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
                        password_confirmation: '123456', confirmation_token: nil, confirmed_at: Time.now)
    @recipe = Recipe.create(name: 'Test recipe', preparation_time: 10.2, cooking_time: 20.3,
                            description: 'Test description', public: true, users_id: @user.id)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end
  describe ' pulic recipes page ' do
    scenario 'should have public recipes page' do
      visit public_recipes_path
      expect(page).to have_content('Public Recipes')
    end
    scenario 'should have name of recipe on public recipes page' do
      visit public_recipes_path
      expect(page).to have_content(@recipe.name)
    end
    scenario 'should have a user name on public recipes page' do
      visit public_recipes_path
      expect(page).to have_content(@user.name)
    end
  end
  describe ' recipes list  page ' do
    scenario 'should have recipes list page' do
      visit recipes_path
      expect(page).to have_http_status(200)
    end
    scenario 'should have name of recipe on recipes list page' do
      visit recipes_path
      expect(page).to have_content(@recipe.name)
    end
    scenario 'should have description of recipe on recipes list page' do
      visit recipes_path
      expect(page).to have_content(@recipe.description)
    end
    scenario 'should have a remove button on recipes list page' do
      visit recipes_path
      expect(page).to have_content('Remove')
    end
  end
  describe ' new recipe page ' do
    scenario 'should have new recipe page' do
      visit new_recipe_path
      expect(page).to have_content('Add New Recipe')
    end
    scenario 'should have form fields on new recipe page' do
      visit new_recipe_path
      expect(page).to have_field('recipe_name')
      expect(page).to have_field('recipe_preparation_time')
      expect(page).to have_field('recipe_cooking_time')
      expect(page).to have_field('recipe_description')
      expect(page).to have_field('recipe_public')
    end
    scenario 'should have a create recipe button on new recipe page' do
      visit new_recipe_path
      expect(page).to have_button('Create Recipe')
    end
    scenario 'when i click on create recipe button it should create a new recipe' do
      visit new_recipe_path
      fill_in 'recipe_name', with: 'Test recipe'
      fill_in 'recipe_preparation_time', with: 10.2
      fill_in 'recipe_cooking_time', with: 20.3
      fill_in 'recipe_description', with: 'Test description'
      click_on('Create Recipe')
      expect(page).to have_content(@recipe.name)
    end
  end
  describe ' show recipe page ' do
    scenario 'should have show recipe page' do
      visit recipe_path(@recipe)
      expect(page).to have_content(@recipe.name)
    end
    scenario 'should have recipe details on show recipe page' do
      visit recipe_path(@recipe)
      expect(page).to have_content(@recipe.name)
      expect(page).to have_content(@recipe.preparation_time)
      expect(page).to have_content(@recipe.cooking_time)
    end
    scenario 'should have Add ingredient  button on show recipe page' do
      visit recipe_path(@recipe)
      expect(page).to have_content('Add ingredient')
    end
    scenario 'should have Generate shopping list button on show recipe page' do
      visit recipe_path(@recipe)
      expect(page).to have_content('Generate shopping list')
    end
    scenario 'when i click on Add ingredient button it should add ingredient ' do
      visit recipe_path(@recipe)
      find('a', text: 'Add ingredient', match: :first).click
      expect(page).to have_content('Add ingredient')
    end
  end
end
