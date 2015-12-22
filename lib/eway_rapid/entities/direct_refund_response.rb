module EwayRapid
  class DirectRefundResponse
    attr_accessor :authorisation_code
    attr_accessor :response_code
    attr_accessor :response_message
    attr_accessor :transaction_id
    attr_accessor :transaction_status
    attr_accessor :verification
    attr_accessor :customer
    attr_accessor :refund
    attr_accessor :errors

    alias_method :transaction_status?, :transaction_status

    def to_json(options={})
      {Constants::AUTHORISATION_CODE  => authorisation_code,
       Constants::RESPONSE_CODE       => response_code,
       Constants::TRANSACTION_ID      => transaction_id,
       Constants::TRANSACTION_STATUS  => transaction_status,
       Constants::VERIFICATION        => verification,
       Constants::CUSTOMER            => customer,
       Constants::REFUND              => refund,
       Constants::ERRORS_CAPITALIZED  => errors}.to_json
    end

    def self.from_json(json)
      hash = JSON.parse(json)
      from_hash(hash)
    end

    def self.from_hash(hash)
      direct_refund_response = DirectRefundResponse.new
      direct_refund_response.authorisation_code = hash[Constants::AUTHORISATION_CODE]
      direct_refund_response.response_code = hash[Constants::RESPONSE_CODE]
      direct_refund_response.transaction_id = hash[Constants::TRANSACTION_ID]
      direct_refund_response.transaction_status = hash[Constants::TRANSACTION_STATUS]
      direct_refund_response.verification = hash[Constants::VERIFICATION]
      direct_refund_response.customer = InternalModels::Customer.from_hash(hash[Constants::CUSTOMER])
      direct_refund_response.refund = InternalModels::RefundDetails.from_hash(hash[Constants::REFUND])
      direct_refund_response.errors = hash[Constants::ERRORS_CAPITALIZED]
      direct_refund_response
    end
  end
end
