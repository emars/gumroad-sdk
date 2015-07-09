require 'spec_helper'

access_token = '0be182abfd7987686377eb1e535dba00073edd74ffb45be34fd0ce3929c31962'
test_id = nil

describe Gumroad::Product do
  before :all do
    File.write('test.txt', 'test')
  end

  after :all do
    File.delete('test.txt')
  end


  Gumroad.set_token(access_token)
  it 'should return a list of products' do
    products = Gumroad::Product.all
    expect(products).to be_an(Array)
  end

  it 'should create a new product' do
    product = Gumroad::Product.create('test.txt',
      {
      name: 'test file',
      url: 'http://zepho.com/rails/books/the-rspec-book.pdf',
      price: 0
    })
    test_id = product.id
    expect(product).to be_a(Gumroad::Product)
  end


  it 'should return a single product' do
    product = Gumroad::Product.find(test_id)
    expect(product).to be_a(Gumroad::Product)
  end


  it 'should delete a product' do
    product = Gumroad::Product.find(test_id)
    product.delete
    product = Gumroad::Product.find(test_id)
    expect(product.deleted).to eq(true)
  end
end
