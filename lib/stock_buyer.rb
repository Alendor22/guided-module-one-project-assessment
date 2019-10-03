class StockBuyer < ActiveRecord::Base

    has_many :transactions
    has_many :companys, through: :transactions

end