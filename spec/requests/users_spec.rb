require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before(:each) do
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
                        password_confirmation: '123456', confirmation_token: nil, confirmed_at: Time.now)
    @recipe = Recipe.create(name: 'Test recipe', preparation_time: 10.2, cooking_time: 20.3,
                            description: 'Test description', public: true, users_id: @user.id)
    @recipe_two = Recipe.create(name: 'Test recipe Two', preparation_time: 10.2, cooking_time: 20.3,
                                description: 'Test description two', public: true, users_id: @user.id)
  end
  describe 'GET /public recipe' do
    it 'returns http success' do
      get public_recipes_path
      expect(response).to have_http_status(200)
    end
    it 'renders the index template' do
      get public_recipes_path
      expect(response).to render_template('index').or(render_template('recipes/public_recipes'))
    end
    it 'displays the recipe name' do
      get public_recipes_path
      expect(response.body).to include(@user.recipes.first.name)
    end
  end

  describe 'GET /sign_in' do
    it 'returns http success' do
      get new_user_session_path
      expect(response).to have_http_status(200)
    end
    it 'renders the new template' do
      get new_user_session_path
      expect(response).to render_template('new').or(render_template('devise/sessions/new'))
    end
    it 'displays the sign in form' do
      get new_user_session_path
      expect(response.body).to include('Log in')
    end
  end
  describe 'GET /sign_up' do
    it 'returns http success' do
      get new_user_registration_path
      expect(response).to have_http_status(200)
    end
    it 'renders the new template' do
      get new_user_registration_path
      expect(response).to render_template('new').or(render_template('devise/registrations/new'))
    end
    it 'displays the sign up form' do
      get new_user_registration_path
      expect(response.body).to include('Sign up')
    end
  end
  describe 'GET /users/confirmation/new' do
    it 'returns http success' do
      get new_user_confirmation_path
      expect(response).to have_http_status(200)
    end
    it 'renders the new template' do
      get new_user_confirmation_path
      expect(response).to render_template('new').or(render_template('devise/confirmations/new'))
    end
    it 'displays the confirmation form' do
      get new_user_confirmation_path
      expect(response.body).to include('Resend confirmation instructions')
    end
  end
  describe 'GET /users/password/new' do
    it 'returns http success' do
      get new_user_password_path
      expect(response).to have_http_status(200)
    end
    it 'renders the new template' do
      get new_user_password_path
      expect(response).to render_template('new').or(render_template('devise/passwords/new'))
    end
    it 'displays the password form' do
      get new_user_password_path
      expect(response.body).to include('Forgot your password?')
    end
  end
end
