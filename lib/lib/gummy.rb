require "gummy/version"
require "gummy/product"

module Gummy
  def self.set_token(token)
    @@token = token
  end
end
