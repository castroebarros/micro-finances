class AddPayableToMicroPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :micro_payments, :payable_id, :integer
    add_column :micro_payments, :payable_type, :string
  end
end
