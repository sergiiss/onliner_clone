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

    if @category.update_attributes(category_params)
      redirect_to @category
    else
      render :edit
    end
  end

  def change_priority
    params.each do |key, value|
      if Category.find_by(:id => key)
        category = Category.find_by(:id => key)

        category.update_attributes(:priority => value)
      end
    end

    redirect_to priority_list_path
  end

  def priority_list
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category
    else
      render :new
    end
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
