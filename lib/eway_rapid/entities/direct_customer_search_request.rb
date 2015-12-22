module EwayRapid
  class DirectCustomerSearchRequest
    attr_accessor :token_customer_id

    def to_json(options={})
      {Constants::TOKEN_CUSTOMER_ID => token_customer_id}.to_json
    end
  end
end
