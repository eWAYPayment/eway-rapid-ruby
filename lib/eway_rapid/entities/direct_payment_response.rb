module EwayRapid
  class DirectPaymentResponse
    attr_accessor :authorisation_code
    attr_accessor :response_code
    attr_accessor :response_message
    attr_accessor :transaction_id
    attr_accessor :transaction_status
    attr_accessor :transaction_type
    attr_accessor :beagle_score
    attr_accessor :errors
    attr_accessor :transaction_captured
    attr_accessor :fraud_action
    attr_accessor :verification
    attr_accessor :customer
    attr_accessor :payment

    alias_method :transaction_status?, :transaction_status

    def to_json(options={})
      {Constants::AUTHORISATION_CODE   => authorisation_code,
       Constants::RESPONSE_CODE        => response_code,
       Constants::RESPONSE_MESSAGE     => response_message,
       Constants::TRANSACTION_ID       => transaction_id,
       Constants::TRANSACTION_STATUS   => transaction_status,
       Constants::TRANSACTION_TYPE     => transaction_type,
       Constants::BEAGLE_SCORE         => beagle_score,
       Constants::ERRORS_CAPITALIZED   => errors,
       Constants::TRANSACTION_CAPTURED => transaction_captured,
       Constants::FRAUD_ACTION         => fraud_action,
       Constants::VERIFICATION         => verification,
       Constants::CUSTOMER             => customer,
       Constants::PAYMENT              => payment}.to_json
    end

    def self.from_json(json)
      hash = JSON.parse(json)
      from_hash(hash)
    end

    def self.from_hash(hash)
      direct_payment_response = DirectPaymentResponse.new
      direct_payment_response.authorisation_code = hash[Constants::AUTHORISATION_CODE]
      direct_payment_response.response_code = hash[Constants::RESPONSE_CODE]
      direct_payment_response.response_message = hash[Constants::RESPONSE_MESSAGE]
      direct_payment_response.transaction_id = hash[Constants::TRANSACTION_ID]
      direct_payment_response.transaction_status = hash[Constants::TRANSACTION_STATUS]
      direct_payment_response.transaction_type = hash[Constants::TRANSACTION_TYPE]
      direct_payment_response.beagle_score = hash[Constants::BEAGLE_SCORE]
      direct_payment_response.errors = hash[Constants::ERRORS_CAPITALIZED]
      direct_payment_response.transaction_captured = hash[Constants::TRANSACTION_CAPTURED]
      direct_payment_response.fraud_action = hash[Constants::FRAUD_ACTION]
      direct_payment_response.verification = InternalModels::Verification.from_hash(hash[Constants::VERIFICATION]) if hash[Constants::VERIFICATION]
      direct_payment_response.customer = InternalModels::Customer.from_hash(hash[Constants::CUSTOMER])
      direct_payment_response.payment = InternalModels::Payment.from_hash(hash[Constants::PAYMENT])
      direct_payment_response
    end
  end
end
