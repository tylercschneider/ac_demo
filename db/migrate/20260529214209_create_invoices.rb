class CreateInvoices < ActiveRecord::Migration[8.1]
  def change
    create_table :invoices do |t|
      t.references :user, null: false, foreign_key: true
      t.string :invoice_id
      t.string :date
      t.string :amount
      t.string :status

      t.timestamps
    end
  end
end
