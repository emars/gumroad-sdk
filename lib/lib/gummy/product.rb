require 'faraday'
require 'json'

API_ROOT = 'https://api.gumroad.com/v2/products'

module Gummy
  class Product
    attr_accessor :id, :description, :name

    def initialize(attributes)
      #@description = attributes["description"]
    end

    def self.all
      response = Faraday.get("#{API_ROOT}", {'access_token' => Gummy.token})
      cars = JSON.parse(response.body)
      cars.map { |attributes| new(attributes)  }
    end

    def self.find(id)
      response = Faraday.get("#{API_ROOT}/#{id}", {'access_token' => Gummy.token})
      attributes = JSON.parse(response.body)
      new(attributes)
    end
  end
end
