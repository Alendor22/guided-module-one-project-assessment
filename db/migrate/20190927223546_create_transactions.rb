class CreateTransactions < ActiveRecord::Migration[5.2]
  def change

    create_table :transactions do |t|
      # foreign keys
      t.integer :stock_buyer_id
      t.integer :company_id
      t.string  :stock
      t.float   :price
    
    
    end

  end



end
