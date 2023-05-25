class RecipeFoodsController < ApplicationController
  def new
    @recipe = Food.all
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe = current_user.recipes.find(params[:recipe_id])
    @recipe_food = RecipeFood.new(recipe_food_params.merge(recipe_id: @recipe.id))
    if @recipe_food.save
      redirect_to request.referrer
    else
      render :new
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_to request.referrer
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
