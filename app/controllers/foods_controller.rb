class FoodsController < ApplicationController
  before_action :authenticate_user!, except: [:public_recipes]

  def index
    @foods = current_user.foods
  end

  def show
    @foods = current_user.foods
  end

  def new; end

  def create
    @food = current_user.foods.new(food_params)
    if @food.save
      flash[:notice] = 'Food was successfully created.'
      redirect_to food_path(@food)
    else
      flash.now[:alert] = 'Food was not created.'
      render :index
    end
  end

  def destroy
    @food = Food.find(params[:id])
    if @food.destroy
      redirect_to foods_path, notice: 'Food deleted successfuly'
    else
      redirect_to foods_path, alert: 'Oops something went wrong'
    end
  end

  def general_shopping_lists
    @shopping_list = Food.select('foods.name', 'SUM(recipe_foods.quantity) AS total_quantity',
                                 'foods.quantity AS food_quantity', 'foods.price')
      .joins(recipe_foods: :recipe)
      .where(users_id: current_user.id)
      .group('foods.name, foods.quantity, foods.price')
      .having('SUM(recipe_foods.quantity) > foods.quantity')

    @total_food_items = @shopping_list.length

    @total = @shopping_list.sum { |food| (food.total_quantity - food.food_quantity) * food.price }
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :quantity, :price)
  end
end
