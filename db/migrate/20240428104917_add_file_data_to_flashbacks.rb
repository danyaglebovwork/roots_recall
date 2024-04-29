class AddFileDataToFlashbacks < ActiveRecord::Migration[7.2]
  def change
    add_column :flashbacks, :file_data, :jsonb
  end
end
