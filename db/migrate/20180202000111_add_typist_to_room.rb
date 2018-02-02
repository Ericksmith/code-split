class AddTypistToRoom < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :typist, :string
  end
end
