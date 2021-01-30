class CreateUserPhoto < ActiveRecord::Migration[6.0]
  def change
    create_table :user_photos do |t|
      t.references :photo, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
