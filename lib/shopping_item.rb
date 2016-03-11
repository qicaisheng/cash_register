require 'promotion'

class ShoppingItem
  attr_reader :commodity, :quantity

  def initialize(commodity, quantity)
    @commodity = commodity
    @quantity = quantity
  end

  def cost_price
    @quantity * @commodity.unit_price - save_price
  end

  def save_price
    price = 0.05 * @quantity * @commodity.unit_price \
      if nine_five_discount?
    price || 0
  end

  def print_item
    puts "名称：#{@commodity.name}，数量：#{@quantity}#{@commodity.unit}，" + \
      "单价：#{format('%.2f', @commodity.unit_price)}(元)，" + \
      "小计：#{format('%.2f', cost_price)}(元)" + \
      "#{'，节省' + format('%.2f', save_price) + '(元)' if nine_five_discount?}"
  end

  private

  def nine_five_discount?
    Promotion.nine_five_discount_items && \
      Promotion.nine_five_discount_items.include?(@commodity.barcode)
  end
end
