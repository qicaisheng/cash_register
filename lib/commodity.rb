class Commodity
  attr_accessor :name,
                :unit,
                :unit_price,
                :category,
                :barcode

  def initialize(params)
    assign_attributes(params)
  end

  private

  def assign_attributes(params)
    params.each do |attribute, value|
      send "#{attribute}=", value
    end
  end
end
