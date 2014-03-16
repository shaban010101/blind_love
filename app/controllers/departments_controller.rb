class DepartmentsController < ApplicationController
  skip_before_filter :authenticate_user!, [:show]
  respond_to :html, :js

  def show
    @department = Department.find(params[:id])
    @dc = @department.category_departments
    @products = Product.products_department(@department)
    respond_with(@products)
  rescue ActiveRecord::RecordNotFound
    render :file => "#{Rails.root}/public/404"
  end
end