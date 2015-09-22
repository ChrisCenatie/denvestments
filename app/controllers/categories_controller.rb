class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @loans = @category.loans
  end
end