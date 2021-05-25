class AddPaymentToPurchase < ActiveRecord::Migration[6.1]
  def change
    add_column :purchases, :receipt_url, :string
    add_column :purchases, :payment_intent_id, :string
  end
end
