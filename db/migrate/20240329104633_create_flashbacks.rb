class CreateFlashbacks < ActiveRecord::Migration[7.2]
  def change
    create_table :flashbacks do |t|
      t.references :user
      t.string :title, null: false
      t.text :content

      t.timestamps
    end
  end
end
