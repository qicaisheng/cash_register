require 'commodity_record'

describe CommodityRecord do
  describe 'records' do
    it 'returns the commodity records' do
      CommodityRecord.refresh
      expect(CommodityRecord.records.map(&:name)).to eq %w(羽毛球 可口可乐 苹果)
    end
  end
end
