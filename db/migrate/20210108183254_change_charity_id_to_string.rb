class ChangeCharityIdToString < ActiveRecord::Migration[6.0]
  def change
    change_column :recipes, :charity_id, :string
  end
end
