class RecipesController < ApplicationController
  def index
    @recipe = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new; end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      flash[:notice] = 'recipe was successfully created.'
      redirect_to recipes_path
    else
      flash.now[:alert] = 'recipe was not created.'
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
      if @recipe.destroy
        redirect_to recipe_path, notice: 'Food deleted successfuly'
      else
        redirect_to recipe_path, alert: 'Oops something went wrong'
      end
  end

  def public_recipes
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  private

  def recipe_params
    params.required(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end
end
