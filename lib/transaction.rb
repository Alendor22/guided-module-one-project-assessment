class Transaction < ActiveRecord::Base

    belongs_to :stock_buyer
    belongs_to :company

end 