require 'faraday'
require 'json'

API_ROOT = 'https://api.gumroad.com/v2/user'

module Gumroad
  class User
    attr_reader :name, :id, :bio, :email

    def initialize(attrs)
      @name = attrs['name']
      @id = attrs['id']
      @bio = attrs['bio']
      @email = attrs['email']
    end

    def self.get
      response = Faraday.get("#{API_ROOT}", {'access_token' => Gumroad.token})
      attrs = JSON.parse(response.body)
      new(attrs['user'])
    end
  end
end