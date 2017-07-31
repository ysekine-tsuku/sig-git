require 'set'
require 'ostruct'

class Machine
  attr_reader :remains, :stock

  # クラスDrinkを作らずに，在庫データを保持する新しいStructを作る． 
  Stock = Struct.new(:name, :price, :num)

  def initialize(remains, usable_money)
    # STEP 1
    @remains, @Usable_money = remains, Set.new(usable_money) 

    # STEP 2
    @stock = Set.new
    @stock << Stock.new("コーラ",120, 5)
    @stock << Stock.new("レッドブル", 200, 5)
    @stock << Stock.new("水", 100, 5)

    # STEP 3
    @sales = 0
  end

  
  # STEP 1
  def can?(money)
    @Usable_money.include?(money)
  end

  def put_money(money)
    @remains += money 
  end
  
  def refund
    puts "refund #{@remains}"
    @remains = 0
  end
  
  # STEP 2
  def available
    available_list = []
    @stock.each{|item| if item.price <= @remains; available_list << item.name;end  }
    return available_list
  end

  def buy(want)
    @stock.each do |item| 
      if item.name == want
        item.num -= 1
        @sales += item.price
        return change = @remains - item.price
      end
    end
  end
end


machine1 = Machine.new(0, [10, 50, 100, 500, 1000].freeze)

p machine1.can?(10)
p machine1.can?(1)
p machine1.put_money(10)
p machine1.put_money(10)
p machine1.put_money(100)

machine1.refund
p machine1.put_money(100)
p machine1.put_money(50)

p machine1.stock 

puts "購入可能: #{machine1.available}"
puts "おつり: #{machine1.buy("水")}"
p machine1.stock


