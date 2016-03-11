require 'commodity_record'
require 'promotion'
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
      print_free_one_items
      print_price
      puts '**********************'
    end

    def print_shopping_items
      @shopping_list.each(&:print_item)
    end

    def print_free_one_items
      if @shopping_list.map(&:free_one_discount?).compact.any?
        puts '买二赠一商品：'
        @shopping_list.each(&:print_free_one_item)
        puts '----------------------'
      end
    end

    def print_price
      puts "总计：#{format('%.2f', cost_price)}(元)"
      puts "节省：#{format('%.2f', save_price)}(元)" if save_price != 0
    end

    def cost_price
      @shopping_list.map(&:cost_price).reduce(:+)
    end

    def save_price
      @shopping_list.map(&:save_price).reduce(:+)
    end
  end
end
