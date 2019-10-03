class Company < ActiveRecord::Base

    has_many :transactions
    has_many :stock_buyers, through: :transactions

end 