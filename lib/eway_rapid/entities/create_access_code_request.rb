module EwayRapid
  class CreateAccessCodeRequest
    attr_accessor :customer
    attr_accessor :shipping_address
    attr_accessor :shipping_method
    attr_accessor :items
    attr_accessor :options
    attr_accessor :payment
    attr_accessor :redirect_url
    attr_accessor :method
    attr_accessor :customer_ip
    attr_accessor :device_id
    attr_accessor :checkout_payment
    attr_accessor :checkout_url
    attr_accessor :transaction_type
    attr_accessor :partner_id

    def to_json(opts={})
      {Constants::CUSTOMER            => InternalModels::Customer.to_hash(customer),
       Constants::SHIPPING_ADDRESS    => InternalModels::ShippingAddress.to_hash(shipping_address),
       Constants::SHIPPING_METHOD     => shipping_method,
       Constants::ITEMS               => Models::LineItem.to_array(items),
       Constants::OPTIONS             => InternalModels::Option.to_array(options),
       Constants::PAYMENT             => InternalModels::Payment.to_hash(payment),
       Constants::REDIRECT_URL        => redirect_url,
       Constants::METHOD              => method,
       Constants::CUSTOMER_DEVICE_IP  => customer_ip,
       Constants::DEVICE_ID           => device_id,
       Constants::CHECKOUT_PAYMENT    => checkout_payment,
       Constants::CHECKOUT_URL        => checkout_url,
       Constants::TRANSACTION_TYPE    => transaction_type,
       Constants::PARTNER_ID          => partner_id}.to_json
    end
  end
end
