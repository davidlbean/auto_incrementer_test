class CompanyTradeCounter < ApplicationRecord
  # NOTE:  the counter field defaults to 1.  See the migration
  # for this model.

  belongs_to :company

  # returns the current counter value and increments it
  # for the next call
  def increment
    curr_value = counter
    self.counter = curr_value + 1
    save
    curr_value
  end

  private

  def counter=(i)
    self[:counter] = i
  end

  def counter
    self[:counter]
  end
end
