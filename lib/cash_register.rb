module CashRegister
  class << self
    def perfom
      CommodityRecord.refresh
      scan_shopping_commodities
      print_shopping_list
    end

    private

    def scan_shopping_commodities
    end

    def print_shopping_list
      puts '***<没钱赚商店>购物清单***'
      print_shopping_items
      puts '----------------------'
      print_price
      puts '**********************'
    end

    def print_shopping_items
    end

    def print_price
    end
  end
end
