class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.references :company, foreign_key: true
      t.string :name
      t.integer :nice_id

      t.timestamps
    end
  end
end
