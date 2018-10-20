require 'test_helper'

class CompanyTradeCounterTest < ActiveSupport::TestCase
  test "verify a trade counter gets set for a new company" do
    new_company = Company.create(name: 'new company')
    assert(new_company.company_trade_counter)
  end

  test "verify a new trade counter starts at 1" do
    new_company = Company.create(name: 'new company')
    assert(new_company.company_trade_counter.increment == 1)
  end

  test "counter increments" do 
    new_company = Company.create(name: 'new company')
    orig_value = new_company.company_trade_counter.increment
    next_value = new_company.company_trade_counter.increment
    assert(next_value == orig_value + 1)
  end

  test "cannot access the counter attribute directly" do
    company = Company.create(name: 'new company')
    assert(company.company_trade_counter)
    assert_raises(NoMethodError){ company.company_trade_counter.counter }
  end


end
