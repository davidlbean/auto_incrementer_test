class Company < ApplicationRecord
  has_many :trades
  has_one :company_trade_counter

  after_create :ensure_trade_counter_exists


  def ensure_trade_counter_exists
    if self.company_trade_counter.nil?
      self.create_company_trade_counter
    end
  end

end
