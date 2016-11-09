class CategoriesController < ApplicationController
    before_action :set_category, only: [:edit, :update, :show, :destroy]
    before_action :require_admin, except: [:index, :show]
    
    def index
        @categories = Category.paginate(page: params[:page], per_page: 5).order('name ASC')
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
    
    def update
        if @category.update(category_params)
            flash[:success] = "Category was successfully updated"
            redirect_to categories_path
        else
            render 'edit'
        end
    end
    
    def show
    end
    
    def destroy
        @category.destroy
        flash[:danger] = "Category and all relationships with articles have been deleted"
        redirect_to categories_path
    end
    
    private
    
    def set_category
        @category = Category.find(params[:id])
    end
    
    def category_params
        params.require(:category).permit(:name)
    end
    
    def require_admin
        if !logged_in? || (logged_in? && !current_user.admin?)
            flash[:danger] = "Only admin users can perform this action!"
            redirect_to categories_path
        end
    end
end