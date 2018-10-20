class CreateCompanyTradeCounters < ActiveRecord::Migration[5.2]
  def change
    create_table :company_trade_counters do |t|
      t.references :company, foreign_key: true
      t.integer :counter, default: 1

      t.timestamps
    end
  end
end
