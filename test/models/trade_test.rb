require 'test_helper'

class TradeTest < ActiveSupport::TestCase
  
  test "adding a new trade to company a increments counter on just company a trades" do
    c = Company.create(name: 'new company')
    starting_trade_count = c.trades.count
    new_trade = c.trades.create(name: 'new trade')
    # verify that the nice_id was set
    assert(new_trade.nice_id)
    # verify that it was unique
    total_unique_trades = c.trades.distinct.count(:nice_id)
    assert(total_unique_trades == starting_trade_count + 1)
  end

  test "deleting a trade does not affect the auto-incrementing" do
    c = Company.create(name: 'new company')
    starting_trade_code = c.trades.count
    # add some trades to the company
    3.times do
      new_trade = c.trades.create(name: 'new trade')
    end
    
    # get all the nice_ids
    nice_ids = c.trades.select(:nice_id).map{ |t| t.nice_id }
    last_nice_id = nice_ids.last

    # now delete one of the new trades
    c.trades.last.delete

    # create a new one
    new_trade = c.trades.create(name: 'new trade')
    
    # verify the nice_id on the new one is not one of the earlier nice_ids
    refute(nice_ids.include?(new_trade.nice_id))

    # and just to be sure, the new nice_id should be one greater than that
    # of the deleted trade
    assert(new_trade.nice_id == last_nice_id + 1)

  end

  test "adding trades to one company does not affect another" do
    company_a = Company.create(name: 'company 1')
    company_b = Company.create(name: 'company 2')

    # add some trades to company_a
    5.times do 
      company_a.trades.create(name: 'new trade')
    end

    # verify the nice_ids are from 1-5
    assert(company_a.trades.map{ |t| t.nice_id }.sort == [1,2,3,4,5])

    # create some new trades in company_b
    3.times do
      company_b.trades.create(name: 'new trade')
    end

    # verify the new nice_ids are from 1-3
    assert(company_b.trades.map{ |t| t.nice_id }.sort == [1,2,3])
  end




end
