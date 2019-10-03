class Interface
  
  attr_accessor :stock_buyer, :account
  attr_reader :prompt, :price, :stock, :stock_buyer_id, :company_id, :name

  def initialize
    @prompt = TTY::Prompt.new
  end

  def handle_new_stock_buyer
    stock_buyer_name = TTY::Prompt.new.ask("Please enter your name:")
    account = TTY::Prompt.new.ask("Please enter an ammount to open your account:")
    @stock_buyer = StockBuyer.create(name: "#{stock_buyer_name}", account: "#{account}")
    create_system(stock_buyer)
  end

  #menu list
  def create_system(stock_buyer)
    prompt.select("Please Select Your Option") do |menu|
      menu.choice "Veiw Balance", -> { view_balance }
      menu.choice "Deposit", -> { make_deposit }
      menu.choice "Withdrawl", -> { make_withdrawl }
      menu.choice "Buy Stock", -> { buy_stock(stock_buyer) }
      menu.choice "View Transactions", -> { transactions(stock_buyer) }
      menu.choice "Create Account", -> { handle_new_stock_buyer }
      menu.choice "Close All Accounts", -> { close_all_accounts }
      menu.choice "Exit", -> { exit_method }
    end
  end

  #This login method is displayed first
  def login
    puts "Welcome, Please sign-in to your account."
    prompt.select "Do you have an account?" do |menu|
      menu.choice "Yes", -> do
        name = prompt.ask("Please enter your name:").downcase
        @stock_buyer = StockBuyer.find_by(name: name)
        
        if @stock_buyer.nil?
          puts "Sorry, I cannot find an account with that name."
          prompt.select "What would you like to do?" do |menu|
            menu.choice "Try Again", -> { login }
            menu.choice "Create Account", -> { handle_new_stock_buyer }
            menu.choice "Exit", -> { exit_method }
          end
        end
      end
      menu.choice "No, Create New Stock Buyer Portal", -> { handle_new_stock_buyer }
      menu.choice "Exit The System", -> { exit_method }
    end
    create_system(stock_buyer)
  end

  def view_balance
    total = @stock_buyer.account
    if @stock_buyer.account < 0
      puts "Your current balance is overdrawn by: #{total}."
    else
      puts "Your balance is: #{@stock_buyer.account}."
    end
    create_system(stock_buyer)
  end

  def make_deposit
    puts "How much would you like to deposit?"
    amount = prompt.ask("Enter an amount to deposit:")
    total = stock_buyer.account + amount.to_f
    stock_buyer.update(account: total)
    create_system(stock_buyer)
  end

  def make_withdrawl
    puts "How much would you like to withdraw?"
    amount = prompt.ask("Enter an ammount to withdraw:")
    total = @stock_buyer.account - amount.to_f
    stock_buyer.update(account: total)
    create_system(stock_buyer)
  end

   def buy_stock(stock_buyer)
    puts "Welcome to the stock purchasing platfom."
    all_companies = Company.all.map {|company| company.stock}.join(",")
    stock = prompt.select( "What stock would you like to buy?", all_companies.split(",")) 
    comp = Company.find_by(stock: stock)
    stock_buyer.transactions.create(stock_buyer_id: stock_buyer.id, company_id: comp.id, stock: stock,
    price: comp.price)
    create_system(stock_buyer)
   end
  
  # def update_stock_buyer_account(stock_buyer)
  #   all_companies = stock_buyer.companies.map {|company| company.stock}.join(",")
  #    stock = prompt.select( "What stock would you like to buy?", all_companies.split(",")) 
  #   total1 = @stock_buyer.account
  #   stock_price = stock_buyer.company.find_by(stock: stock)
  #    price_arr = Company.all.map {|company| company.price}
  #    stock_arr = Company.all.map {|company| company.stock}
  #    stock_arr = Company.all.select {|company| company}.each {|c| c.stock, c.price}
  #    amount = prompt.ask("Enter the amount of shares you'd like to purchase:") 
  #   total_price_of_shares_purchased = (stock_price)
  #   total2 = total1 - total_price_of_shares_purchased
  #   stock_buyer.update(account: total2)
  #   create_system(stock_buyer)
  # end
  # def read_id_of_stock_buyer
  #   stock_buyer_id_arr = StockBuyer.all.map {|name| name.id}
  #   name = prompt.select("Please enter the name of the stock buyer whose id you'd like to retrieve:")
  #   id_name_arr = (StockBuyer.all.map {|stock_buyer| [stock_buyer["name"], stock_buyer["id"]]}).find_by(name: id)
  # end
  # name_id = stock_buyer_id_arr.all.find {|id| id.name == name}
    
  def transactions(stock_buyer)
   stock_buyer.transactions.each{|i| puts "Transaction: #{i.price}, #{i.stock}"}

   create_system(stock_buyer)
  end

  def close_all_accounts
    StockBuyer.destroy_all
    puts "All accounts have are now closed."
    create_system(stock_buyer)
  end

  @stock_buyer

  
  def exit_method
    exit
  end

  # def admin
  #   @prompt.select("Are You a stock buyer or administrator") do |menu|
  #     menu.choice "Stock_buyer", -> { login }
  #     menu.choice "Administrator",  -> { password }
  #    end
  # end

  # def password
  #   password = @prompt.ask("Please Enter Password") do |menu|
  #     if password == "Adeja"
  #       admin_view
  # end
 
end