class FoodsController < ApplicationController
  before_action :authenticate_user!

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

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :quantity, :price)
  end
end
