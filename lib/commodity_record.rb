require 'json'
require 'commodity'

module CommodityRecord
  class << self
    attr_reader :records

    def refresh
      file_path = File.expand_path('../../data/commodity_records.json', __FILE__)
      @records = JSON.parse(File.read(file_path)).map { |commodity_params|
        Commodity.new(commodity_params)
      }
    end

    def find(barcode)
      @records.find { |commodity| commodity.barcode == barcode }
    end
  end
end
