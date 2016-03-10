require 'commodity_record'
require 'shopping_item'

module CashRegister
  class << self
    attr_reader :shopping_list

    def perfom
      CommodityRecord.refresh
      scan_shopping_commodities
      print_shopping_list
    end

    private

    def scan_shopping_commodities
      file_path = File.expand_path('../../data/shopping_list.json', __FILE__)
      barcode_array = JSON.parse(File.read(file_path))
      barcode_with_quantity = barcode_array.group_by { |item| item }
      @shopping_list = barcode_with_quantity.map do |k, v|
        if k.include? '-'
          barcode, quantity = k.split('-')
        else
          barcode = k
          quantity = v.count
        end
        commodity = CommodityRecord.find(barcode)
        ShoppingItem.new(commodity, quantity.to_i)
      end
    end

    def print_shopping_list
      puts '***<没钱赚商店>购物清单***'
      print_shopping_items
      puts '----------------------'
      print_price
      puts '**********************'
    end

    def print_shopping_items
      @shopping_list.each(&:print_item)
    end

    def print_price
      puts "总计：#{format('%.2f', cost_price)}(元)"
    end

    def cost_price
      @shopping_list.map(&:price).reduce(:+)
    end
  end
end
