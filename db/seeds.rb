StockBuyer.destroy_all
Transaction.destroy_all
Company.destroy_all

blackrock = Company.create(name: "Blackrock", stock: "AAPL", price: 218.82)
gs = Company.create(name: "GoldmanSachs", stock: "AZN", price: 1725.45)
pwc = Company.create(name: "PWC", stock: "GOOG", price: 1225.09)
blackrock = Company.create(name: "Blackrock", stock: "MSFT", price: 135.33)
ubs = Company.create(name: "UBS", stock: "FB", price: 174.86)
hsbc = Company.create(name: "HSBC", stock: "INTC", price: 50.04)
citigroup = Company.create(name: "Citigroup", stock: "BABA", price: 165.16)
gs = Company.create(name: "GoldmanSachs", stock: "DIS", price: 129.14)
pwc = Company.create(name: "PWC", stock: "TWTR", price: 39.70)
UBS = Company.create(name: "UBS", stock: "KO", price: 52.42)
citigroup = Company.create(name: "Citigroup", stock: "TIF", price: 88.84)
