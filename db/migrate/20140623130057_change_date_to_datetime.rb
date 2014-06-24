class ChangeDateToDatetime < ActiveRecord::Migration
  def change
    change_column :projects, :last_run, :datetime
  end
end
