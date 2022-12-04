class RecipesController < ApplicationController

    def index
        return render json: {errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
        recipe = Recipe.all
        render json: recipe, status: :created
    end

    def create
        return render json: {errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
        user = User.find_by(id: session[:user_id])
        recipe = Recipe.create!(user_id: user.id, title: params[:title], instructions: params[:instructions], minutes_to_complete: params[:minutes_to_complete])
        render json: recipe, status: :created   
    end

    private

    # def recipe_params
    #     params.permit(:user_id, :title, :instructions, :minutes_to_complete)
    # end
end
