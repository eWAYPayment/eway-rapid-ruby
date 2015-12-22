module EwayRapid
  class CapturePaymentResponse
    attr_accessor :response_code
    attr_accessor :response_message
    attr_accessor :transaction_id
    attr_accessor :transaction_status
    attr_accessor :errors

    alias_method :transaction_status?, :transaction_status

    def to_json(options={})
      {Constants::RESPONSE_CODE => response_code,
       Constants::RESPONSE_MESSAGE => response_message,
       Constants::TRANSACTION_ID => transaction_id,
       Constants::TRANSACTION_STATUS => transaction_status,
       Constants::ERRORS => errors}.to_json
    end

    def self.from_json(json)
      hash = JSON.parse(json)
      from_hash(hash)
    end

    def self.from_hash(hash)
      capture_payment_response = CapturePaymentResponse.new
      capture_payment_response.response_code = hash[Constants::RESPONSE_CODE]
      capture_payment_response.response_message = hash[Constants::RESPONSE_MESSAGE]
      capture_payment_response.transaction_id = hash[Constants::TRANSACTION_ID]
      capture_payment_response.transaction_status = hash[Constants::TRANSACTION_STATUS]
      capture_payment_response.errors = hash[Constants::ERRORS_CAPITALIZED]
      capture_payment_response
    end
  end
end
