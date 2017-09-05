class AddInterestPenaltyAndDiscountToMicroPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :micro_payments, :interest_value, :decimal
    add_column :micro_payments, :penalty_value, :decimal
    add_column :micro_payments, :discount_value, :decimal
  end
end
