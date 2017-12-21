class AddCodeToRoom < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :code, :text
  end
end
