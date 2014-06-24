class AddCommitToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :commit, :string
  end
end
