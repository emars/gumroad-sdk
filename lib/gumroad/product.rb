require 'faraday'
require 'json'

API_ROOT = 'https://api.gumroad.com/v2/products'

module Gumroad 
  class Product
    attr_reader :id,
      :formatted_price,
      :view_count,
      :sales_count,
      :sales_usd_cents,
      :deleted

    attr_accessor :name,
      :file,
      :price,
      :description,
      :preview_url, 
      :countries_available,
      :max_purchase_count,
      :customizable_price,
      :webhook,
      :require_shipping,
      :shown_on_profile,
      :custom_recipt,
      :custom_summary,
      :custom_permalink,
      :is_recurring_billing,
      :subscription_duration

    def initialize(attributes)
      @id                    = attributes['id']
      @custom_receipt        = attributes['custom_receipt']
      @custom_summary        = attributes['custom_summary']
      @custom_fields         = attributes['custom_fields']
      @customizable_price    = attributes['customizable_price']
      @deleted               = attributes['deleted']
      @max_purchase_count    = attributes['max_purchase_count']
      @name                  = attributes['name']
      @require_shipping      = attributes['require_shipping']
      @subscription_duration = attributes['subscription_duration']
      @custom_permalink      = attributes['custom_permalink']
      @published             = attributes['published']
      @url                   = attributes['url']
      @webhook               = attributes['webhook']
      @price                 = attributes['price']
      @custom_product_type   = attributes['custom_product_type']
      @countries_available   = attributes['countries_available']
      @short_url             = attributes['short_url']
      @formatted_price       = attributes['formatted_price']
      @description           = attributes['description']
      @preview_url           = attributes['preview_url']
      @file_info             = attributes['file_info'] 
      @shown_on_profile      = attributes['shown_on_profile']
      @view_count            = attributes['view_count']
      @sales_count           = attributes['sales_count']
      @sales_usd_cents       = attributes['sales_usd_cents']
    end

    def save
      response = Faraday.put("#{API_ROOT}/#{@id}", serialize)
      data = JSON.parse(response.body)
      new(data['product'])
    end

    def delete
      data = { access_token: Gumroad.get_token }
      response = Faraday.delete("#{API_ROOT}/#{@id}", data)
      JSON.parse(response.body)
    end

    def offer_codes
    end

    def offer_code
    end

    def create_offer_code(data)
    end

    def variant
    end

    def create_variant
    end

    def custom_fields
    end

    def custom_field(id)
    end

    def create_custom_field
    end

    def self.create(file, data)
      data['access_token'] = Gumroad.get_token
      response = Faraday.post("#{API_ROOT}", data)
      data = JSON.parse(response.body)
      new(data['product'])
    end

    def self.all
      response = Faraday.get("#{API_ROOT}", {'access_token' => Gumroad.get_token})
      data = JSON.parse(response.body)
      data['products'].map { |attributes| new(attributes)  }
    end

    def self.find(id)
      response = Faraday.get("#{API_ROOT}/#{id}", {'access_token' => Gumroad.get_token})
      data = JSON.parse(response.body)
      new(data['product'])
    end

    private
    def serialize
      {
        access_token: Gumroad.get_token,
        name: @name,
        file: @file,
        price: @price,
        description: @description,
        countries_available: @countries_available,
        max_purchases_count: @max_purchases_count,
        customizable_price: @customizable_price,
        webhook: @webhook,
        require_shipping: @require_shipping,
        shown_on_profile: @shown_on_profile,
        custom_receipt: @custom_receipt,
        custom_summary: @custom_summary,
        custom_permalink: @custom_permalink,
        is_recurring_billing: @is_recurring_billing,
        subscription_duration: @subsription_duration
      }
    end
  end
end
