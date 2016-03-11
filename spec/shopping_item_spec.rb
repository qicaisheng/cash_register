require 'shopping_item'
require 'commodity'

describe ShoppingItem do
  before do
    @apple = Commodity.new(
      "name": "苹果",
      "unit": "斤",
      "unit_price": 5.5,
      "barcode": "ITEM000003"
    )
  end
  describe '#cost_price' do
    context 'when no promotion' do
      it 'returns total price' do
        Promotion.refresh
        shopping_item = ShoppingItem.new(@apple, 2)

        expect(shopping_item.cost_price).to eq 11
      end
    end
  end
end
