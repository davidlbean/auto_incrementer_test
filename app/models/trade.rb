class Trade < ApplicationRecord
  belongs_to :company

  before_save :increment_nice_id

  private

  def increment_nice_id
    self.nice_id ||= self.company.company_trade_counter.increment
  end

end
