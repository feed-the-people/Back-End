class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.string :url, index: { unique: true }

      t.timestamps
    end
  end
end
