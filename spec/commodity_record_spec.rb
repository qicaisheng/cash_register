require 'commodity_record'

describe CommodityRecord do
  before do
    CommodityRecord.refresh
  end

  describe 'records' do
    it 'returns the commodity records' do
      expect(CommodityRecord.records.map(&:name)).to eq %w(羽毛球 可口可乐 苹果)
    end
  end

  describe '#find' do
    context 'when commodity in records' do
      it 'returns the commodity' do
        expect(CommodityRecord.find('ITEM000003').name).to eq '苹果'
      end
    end

    context 'when commodity does not in records' do
      it 'returns nil' do
        egg = Commodity.new(name: '鸡蛋', unit: '斤', unit_price: 5, barcode: 'ITEM000004')
        expect(CommodityRecord.find(egg.barcode)).to eq nil
      end
    end
  end
end
