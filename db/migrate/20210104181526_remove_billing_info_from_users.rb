class RemoveBillingInfoFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :billing_info, :string
  end
end
