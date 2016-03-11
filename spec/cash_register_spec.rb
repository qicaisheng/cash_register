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
        expect($stdout.string).to eq [
          '***<没钱赚商店>购物清单***',
          '名称：羽毛球，数量：5个，单价：1.00(元)，小计：5.00(元)',
          '名称：苹果，数量：2斤，单价：5.50(元)，小计：11.00(元)',
          '名称：可口可乐，数量：3瓶，单价：3.00(元)，小计：9.00(元)',
          '----------------------',
          '总计：25.00(元)',
          "**********************\n"
        ].join("\n")
      end
    end

    context 'when have 95% discount' do
      it 'puts with discount' do
        Promotion.refresh(nine_five: ['ITEM000003'])
        CashRegister.perfom
        expect($stdout.string).to eq [
          '***<没钱赚商店>购物清单***',
          '名称：羽毛球，数量：5个，单价：1.00(元)，小计：5.00(元)',
          '名称：苹果，数量：2斤，单价：5.50(元)，小计：10.45(元)，节省0.55(元)',
          '名称：可口可乐，数量：3瓶，单价：3.00(元)，小计：9.00(元)',
          '----------------------',
          '总计：24.45(元)',
          '节省：0.55(元)',
          "**********************\n"
        ].join("\n")
      end
    end
  end
end
