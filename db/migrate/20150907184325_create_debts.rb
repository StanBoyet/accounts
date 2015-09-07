class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.references :record, index: true, foreign_key: true
      t.references :recipient, index: true, foreign_key: true
    end
  end
end
