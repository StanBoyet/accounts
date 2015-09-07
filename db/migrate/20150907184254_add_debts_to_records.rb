class AddDebtsToRecords < ActiveRecord::Migration
  def change
    add_reference :records, :spender, index: true, foreign_key: true
  end
end
