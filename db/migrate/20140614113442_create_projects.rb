class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :repository
      t.date :last_run
      t.decimal :last_result

      t.timestamps
    end
  end
end
