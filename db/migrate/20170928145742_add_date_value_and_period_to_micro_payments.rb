class AddDateValueAndPeriodToMicroPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :micro_payments, :date, :date
    add_column :micro_payments, :value, :decimal
    add_column :micro_payments, :period, :integer
  end
end
