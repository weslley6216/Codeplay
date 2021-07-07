class RemoveEmailToInstructors < ActiveRecord::Migration[6.1]
  def change
    remove_column :instructors, :email, :string
  end
end
