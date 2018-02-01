class AddLanguageToRoom < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :language, :string
  end
end
