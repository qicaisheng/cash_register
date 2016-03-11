module Promotion
  class << self
    def refresh(discounts = nil)
      @discounts = discounts
    end

    def nine_five_discount_items
      @discounts ? @discounts[:nine_five] : []
    end

    def free_one_discount_items
      @discounts ? @discounts[:free_one] : []
    end
  end
end
