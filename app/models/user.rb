class User < ActiveRecord::Base

  has_many :loans, foreign_key: 'spender_id', :class_name => 'Record'

  has_many :debts, inverse_of: :recipients, :class_name => 'Joins::Debt'
  has_many :bills, through: :debts, inverse_of: :recipients, :class_name => 'Record'

end
