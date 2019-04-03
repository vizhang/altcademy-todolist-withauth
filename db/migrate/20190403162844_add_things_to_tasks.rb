class AddThingsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to :tasks, :user, index: true, foreign_key: true
  end
end
