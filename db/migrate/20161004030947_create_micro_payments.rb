class CreateMicroPayments < ActiveRecord::Migration[5.0]
  def change
    create_table :micro_payments do |t|
      t.string :description
      t.date :due_date
      t.decimal :due_value
      t.date :payment_date
      t.decimal :payment_value
      t.string :effect

      t.timestamps
    end
  end
end
