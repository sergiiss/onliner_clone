class CategoriesController < ApplicationController
  skip_before_action :authenticate_user, only: [ :show ]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    @category.update_attributes(category_params) ? (redirect_to @category) : (render :edit)
  end

  def change_priority
    params.values.map do |foo|
      if foo.class == HashWithIndifferentAccess
        foo.to_hash.each do |key, value|
          if Category.find_by(:id => key.to_i)
            category = Category.find_by(:id => key.to_i)

            if value.size == 1
              category.update_attributes(priority: value[0], main_page: 'false')
            else
              category.update_attributes(priority: value.last.to_i, main_page: value.first)
            end
          end
        end
      end
    end

    redirect_to priority_list_path
  end

  def priority_list
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)

    @category.save ? (redirect_to @category) : (render :new)
  end

  def destroy
    @category = Category.find(params[:id])

    @category.destroy

    redirect_to priority_list_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :priority, :main_page)
  end
end
