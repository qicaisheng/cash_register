require 'cash_register'
require 'stringio'

describe CashRegister do
  before do
    $stdout = StringIO.new
  end
  after(:all) do
    $stdout = STDOUT
  end

  describe '#perfom' do
    context 'when no promotion' do
      it 'puts normal' do
        CashRegister.perfom
        expect($stdout.string.split("\n")).to match_array [
          '***<没钱赚商店>购物清单***',
          '名称：可口可乐，数量：3瓶，单价：3.00(元)，小计：9.00(元)',
          '名称：羽毛球，数量：5个，单价：1.00(元)，小计：5.00(元)',
          '名称：苹果，数量：2斤，单价：5.50(元)，小计：11.00(元)',
          '----------------------',
          '总计：25.00(元)',
          '**********************'
        ]
      end
    end

    context 'when have 95% discount' do
      it 'puts with discount' do
        Promotion.refresh(nine_five: ['ITEM000003'])
        CashRegister.perfom
        expect($stdout.string.split("\n")).to match_array [
          '***<没钱赚商店>购物清单***',
          '名称：可口可乐，数量：3瓶，单价：3.00(元)，小计：9.00(元)',
          '名称：羽毛球，数量：5个，单价：1.00(元)，小计：5.00(元)',
          '名称：苹果，数量：2斤，单价：5.50(元)，小计：10.45(元)，节省0.55(元)',
          '----------------------',
          '总计：24.45(元)',
          '节省：0.55(元)',
          '**********************'
        ]
      end
    end

    context 'when have free one discount' do
      it 'puts with discount' do
        Promotion.refresh(free_one: %w(ITEM000001 ITEM000005))
        CashRegister.perfom
        expect($stdout.string.split("\n")).to match_array [
          '***<没钱赚商店>购物清单***',
          '名称：可口可乐，数量：3瓶，单价：3.00(元)，小计：6.00(元)',
          '名称：羽毛球，数量：5个，单价：1.00(元)，小计：4.00(元)',
          '名称：苹果，数量：2斤，单价：5.50(元)，小计：11.00(元)',
          '----------------------',
          '买二赠一商品：',
          '名称：可口可乐，数量：1瓶',
          '名称：羽毛球，数量：1个',
          '----------------------',
          '总计：21.00(元)',
          '节省：4.00(元)',
          '**********************'
        ]
      end
    end

    context 'when have free one discount and nine five discount' do
      it 'puts with discount' do
        Promotion.refresh(
          free_one: %w(ITEM000001 ITEM000005),
          nine_five: ['ITEM000003']
        )
        CashRegister.perfom(
          [
            'ITEM000001',
            'ITEM000001',
            'ITEM000001',
            'ITEM000001',
            'ITEM000001',
            'ITEM000001',
            'ITEM000003-2',
            'ITEM000005',
            'ITEM000005',
            'ITEM000005'
          ]
        )
        expect($stdout.string.split("\n")).to match_array [
          '***<没钱赚商店>购物清单***',
          '名称：可口可乐，数量：3瓶，单价：3.00(元)，小计：6.00(元)',
          '名称：羽毛球，数量：6个，单价：1.00(元)，小计：4.00(元)',
          '名称：苹果，数量：2斤，单价：5.50(元)，小计：10.45(元)，节省0.55(元)',
          '----------------------',
          '买二赠一商品：',
          '名称：可口可乐，数量：1瓶',
          '名称：羽毛球，数量：2个',
          '----------------------',
          '总计：20.45(元)',
          '节省：5.55(元)',
          '**********************'
        ]
      end
    end
  end
end
