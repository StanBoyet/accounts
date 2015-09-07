module Joins
  class Debt < ActiveRecord::Base

    belongs_to :record
    belongs_to :recipient, class_name: 'User'

  end
end