class AddCommandToProject < ActiveRecord::Migration
  def change
    add_column :projects, :command, :string
  end
end
