class CreateUsersLackingSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :users_lacking_skills do |t|
      t.references :user, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
