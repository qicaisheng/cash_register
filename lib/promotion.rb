module Promotion
  class << self
    def refresh(discounts = nil)
      @discounts = discounts
    end

    def nine_five_discount_items
      @discounts ? @discounts[:nine_five] : []
    end
  end
end
