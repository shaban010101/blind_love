class DepartmentsController < ApplicationController
  skip_before_filter :authorize, [:show]

  def show
    @department = Department.find(params[:id])
    @dc = @department.categories
    @products = @department.products
  rescue ActiveRecord::RecordNotFound
    render :file => "#{Rails.root}/public/404"
  end
end