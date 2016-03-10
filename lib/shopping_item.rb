class ShoppingItem
  attr_reader :commodity, :quantity

  def initialize(commodity, quantity)
    @commodity = commodity
    @quantity = quantity
  end

  def price
    @quantity * @commodity.unit_price
  end

  def print_item
    puts "名称：#{@commodity.name}，数量：#{@quantity}#{@commodity.unit}，单价：#{format('%.2f',@commodity.unit_price)}(元)，小计：#{format('%.2f', price)}(元)"
  end
end
