class CategoriesController < ApplicationController

	def index
		@categories = Category.paginate(page: params[:page], per_page: 6)
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:success] = "Category was successfully created"
			redirect_to categories_path
		else
			render 'new'
		end
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		if @category.update(category_params)
			flash[:success]="Category name was updated successfully"
			redirect_to categories_path(@category)
		else
			render 'edit'
		end
	end

	def show
		@category = Category.find(params[:id])
		@category_quizzes = @category.quizzes.paginate(page: params[:page], per_page: 6)
	end

	private

	def category_params
		 params.require(:category).permit(:name)
	end

end