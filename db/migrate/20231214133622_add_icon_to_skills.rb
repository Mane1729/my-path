class AddIconToSkills < ActiveRecord::Migration[7.0]
  def change
    add_column :skills, :icon, :string
  end
end
