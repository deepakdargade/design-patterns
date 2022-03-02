require 'observer'

class Product
  include Observable

  attr_reader :name, :stock

  def initialize(name = "", stock = 0)
    @name, @stock = name, stock
    add_observer(Notifier.new)
  end

  def update_stock(stock)
    @stock = stock
    changed
    notify_observers(self, stock)
  end
end


# Next, you need a subscriber class that will receive updates on the stock changes:

class Notifier
  def update(product, stock)
    puts "The #{product.name} is in stock" if stock > 0
    puts "The #{product.name} is sold out!" if stock == 0
  end
end

# Finally, this is how you can use them together:

product = Product.new("AB Laptop")

product.update_stock(7)
# => The AB Laptop is in stock

product.update_stock(3)
# => The AB Laptop is in stock

product.update_stock(0)
# => The AB Laptop is sold out!

product.update_stock(2)
# => The AB Laptop is in stock

product.update_stock(0)
# => The AB Laptop is sold out!