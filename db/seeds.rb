# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
department= Department.create([{ department_name: 'Mens' }, { department_name: 'Womens' }, { department_name: 'Kids'}])
category= Category.create([{ category_name: 'Trousers'}, {category_name: 'Shorts'}, {category_name: 'Underwear'}])
product= Product.create([{:name => 'Foo', :price => 'Bar', :description => 'FooBar' }])