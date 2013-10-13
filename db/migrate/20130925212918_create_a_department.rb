class CreateADepartment < ActiveRecord::Migration
  def up
    create_table :departments do |t|
      t.string :department_name

      t.timestamps
    end
  end

  def down
    drop_table :departments
  end
end
