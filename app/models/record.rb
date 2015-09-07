class Record < ActiveRecord::Base

  belongs_to :spender, class_name: 'User', inverse_of: :loans, foreign_key: 'spender_id'

  has_many :debts, class_name: 'Joins::Debt'
  has_many :recipients, through: :debts, class_name: 'User', inverse_of: :bills

end
