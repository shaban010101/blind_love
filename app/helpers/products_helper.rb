module ProductsHelper
  def department_link
    link_to @product.category_department.department.slug.capitalize, department_path(@product.category_department.department.slug)
  end

  def category_link
    link_to @product.category_department.category.slug.capitalize, department_category_path(@product.category_department.department.slug, @product.category_department.category.slug)
  end
end