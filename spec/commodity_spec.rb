require 'commodity'

describe Commodity do
  describe '#initialize' do
    before do
      @values = {
        name: '可口可乐',
        unit: '瓶',
        unit_price: 3,
        barcode: 'ITEM000001'
      }
    end

    it 'returns the initialize object' do
      @commodity = Commodity.new(@values)

      expect(@commodity.name).to eq @values[:name]
      expect(@commodity.unit).to eq @values[:unit]
      expect(@commodity.unit_price).to eq @values[:unit_price]
      expect(@commodity.barcode).to eq @values[:barcode]
    end
  end
end
