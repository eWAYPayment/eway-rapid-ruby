module EwayRapid
  class CreateAccessCodeSharedRequest
    attr_accessor :customer
    attr_accessor :shipping_address
    attr_accessor :items
    attr_accessor :options
    attr_accessor :payment
    attr_accessor :redirect_url
    attr_accessor :cancel_url
    attr_accessor :checkout_url
    attr_accessor :method
    attr_accessor :device_id
    attr_accessor :customer_ip
    attr_accessor :transaction_type
    attr_accessor :logo_url
    attr_accessor :header_text
    attr_accessor :partner_id
    attr_accessor :language
    attr_accessor :customer_read_only
    attr_accessor :custom_view
    attr_accessor :verify_customer_phone
    attr_accessor :verify_customer_email
    attr_accessor :checkout_payment

    def to_json(opts={})
      {
          Constants::CUSTOMER               => InternalModels::Customer.to_hash(customer),
          Constants::SHIPPING_ADDRESS       => InternalModels::ShippingAddress.to_hash(shipping_address),
          Constants::ITEMS                  => Models::LineItem.to_array(items),
          Constants::OPTIONS                => InternalModels::Option.to_array(options),
          Constants::PAYMENT                => InternalModels::Payment.to_hash(payment),
          Constants::REDIRECT_URL           => redirect_url,
          Constants::CANCEL_URL             => cancel_url,
          Constants::CHECKOUT_URL           => checkout_url,
          Constants::METHOD                 => method,
          Constants::DEVICE_ID              => device_id,
          Constants::CUSTOMER_DEVICE_IP     => customer_ip,
          Constants::TRANSACTION_TYPE       => transaction_type,
          Constants::LOGO_URL               => logo_url,
          Constants::HEADER_TEXT            => header_text,
          Constants::PARTNER_ID             => partner_id,
          Constants::LANGUAGE               => language,
          Constants::CUSTOMER_READ_ONLY     => customer_read_only,
          Constants::CUSTOMER_VIEW          => custom_view,
          Constants::VERIFY_CUSTOMER_PHONE  => verify_customer_phone,
          Constants::VERIFY_CUSTOMER_EMAIL  => verify_customer_email,
          Constants::CHECKOUT_PAYMENT       => checkout_payment
      }.to_json
    end
  end
end
