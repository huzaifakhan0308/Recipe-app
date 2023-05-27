require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before(:each) do
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
                        password_confirmation: '123456', confirmation_token: nil, confirmed_at: Time.now)
    @recipe = Recipe.create(name: 'Test recipe', preparation_time: 10.2, cooking_time: 20.3,
                            description: 'Test description', public: true, users_id: @user.id)
  end
  it 'is valid with valid attributes' do
    expect(@recipe).to be_valid
  end
  it 'is not valid without a name' do
    @recipe.name = nil
    expect(@recipe).to_not be_valid
  end
  it 'is not valid without a preparation time' do
    @recipe.preparation_time = nil
    expect(@recipe).to_not be_valid
  end
  it 'is not valid without a cooking time' do
    @recipe.cooking_time = nil
    expect(@recipe).to_not be_valid
  end
  it 'is not valid without a description' do
    @recipe.description = nil
    expect(@recipe).to_not be_valid
  end
  it 'is not valid with a preparation time is nil' do
    @recipe.preparation_time = nil
    expect(@recipe).to_not be_valid
  end
  it 'is not valid with a cooking time is nil' do
    @recipe.cooking_time = nil
    expect(@recipe).to_not be_valid
  end
  it 'it is not valid without a user' do
    @recipe.users_id = nil
    expect(@recipe).to_not be_valid
  end
end
