class CreateStockBuyers < ActiveRecord::Migration[5.2]
  def change

    create_table :stock_buyers do |t|

      t.string :name
      t.float :account
    
    end
  end


end