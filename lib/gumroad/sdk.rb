require "gumroad/sdk/version"

module Gumroad
  def self.get_token
    @@token
  end

  def self.set_token(token)
    @@token = token
  end

  module Sdk
  end
end
