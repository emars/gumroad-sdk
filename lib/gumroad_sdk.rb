require "gumroad/sdk/version"
require "gumroad/product"

module Gumroad
  def self.get_token
    unless @@token 
      raise "No Token" 
    end
    @@token
  end

  def self.set_token(token)
    @@token = token
  end
end
