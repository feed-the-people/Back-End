class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :image
      t.string :title
      t.text :description
      t.string :instructions
      t.integer :charity_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
