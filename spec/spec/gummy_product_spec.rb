require 'spec_helper'

describe Gummy::Product do
  it 'gets a list of products' do
    VCR.use_cassette('products_list') do
      products = Gummy::Product.all

      expect(products).to be_an(Array)
    end
  end
end
