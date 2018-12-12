module EwayRapid
  class DirectPaymentRequest
    attr_accessor :customer
    attr_accessor :shipping_address
    attr_accessor :items
    attr_accessor :options
    attr_accessor :payment
    attr_accessor :method
    attr_accessor :transaction_type
    attr_accessor :secured_card_data
    attr_accessor :customer_ip
    attr_accessor :device_id
    attr_accessor :partner_id
    attr_accessor :redirect_url

    def to_json(opts={})
      {Constants::CUSTOMER           => InternalModels::Customer.to_hash(customer),
       Constants::SHIPPING_ADDRESS   => InternalModels::ShippingAddress.to_hash(shipping_address),
       Constants::ITEMS              => Models::LineItem.to_array(items),
       Constants::OPTIONS            => InternalModels::Option.to_array(options),
       Constants::PAYMENT            => InternalModels::Payment.to_hash(payment),
       Constants::METHOD             => method,
       Constants::TRANSACTION_TYPE   => transaction_type,
       Constants::SECURED_CARD_DATA  => secured_card_data,
       Constants::CUSTOMER_DEVICE_IP => customer_ip,
       Constants::DEVICE_ID          => device_id,
       Constants::PARTNER_ID         => partner_id,
       Constants::REDIRECT_URL       => redirect_url}.to_json
    end
  end
end
