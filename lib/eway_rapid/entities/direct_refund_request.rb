module EwayRapid
  class DirectRefundRequest
    attr_accessor :customer
    attr_accessor :shipping_address
    attr_accessor :refund
    attr_accessor :line_items
    attr_accessor :options
    attr_accessor :device_id
    attr_accessor :customer_ip
    attr_accessor :partner_id

    def to_json(opts={})
      {
          Constants::CUSTOMER           => InternalModels::Customer.to_hash(customer),
          Constants::SHIPPING_ADDRESS   => InternalModels::ShippingAddress.to_hash(shipping_address),
          Constants::REFUND             => InternalModels::RefundDetails.to_hash(refund),
          Constants::LINE_ITEMS         => Models::LineItem.to_array(line_items),
          Constants::OPTIONS            => InternalModels::Option.to_array(options),
          Constants::DEVICE_ID          => device_id,
          Constants::CUSTOMER_DEVICE_IP => customer_ip,
          Constants::PARTNER_ID         => partner_id
      }.to_json
    end

  end
end
