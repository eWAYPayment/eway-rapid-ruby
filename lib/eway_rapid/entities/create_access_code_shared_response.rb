module EwayRapid
  class CreateAccessCodeSharedResponse
    attr_accessor :customer
    attr_accessor :payment
    attr_accessor :access_code
    attr_accessor :form_action_url
    attr_accessor :errors
    attr_accessor :shared_payment_url
    attr_accessor :complete_checkout_url

    def to_json(options={})
      {
          Constants::CUSTOMER               => customer,
          Constants::PAYMENT                => payment,
          Constants::ACCESS_CODE            => access_code,
          Constants::FORM_ACTION_URL        => form_action_url,
          Constants::ERRORS_CAPITALIZED     => errors,
          Constants::SHARED_PAYMENT_URL     => shared_payment_url,
          Constants::COMPLETE_CHECKOUT_URL  => complete_checkout_url
      }.to_json
    end

    def self.from_json(json)
      hash = JSON.parse(json)
      from_hash(hash)
    end

    def self.from_hash(hash)
      create_access_code = CreateAccessCodeSharedResponse.new
      create_access_code.customer = InternalModels::Customer.from_hash(hash[Constants::CUSTOMER])
      create_access_code.payment = InternalModels::Payment.from_hash(hash[Constants::PAYMENT])
      create_access_code.access_code = hash[Constants::ACCESS_CODE]
      create_access_code.form_action_url = hash[Constants::FORM_ACTION_URL]
      create_access_code.errors = hash[Constants::ERRORS_CAPITALIZED]
      create_access_code.shared_payment_url = hash[Constants::SHARED_PAYMENT_URL]
      create_access_code.complete_checkout_url = hash[Constants::COMPLETE_CHECKOUT_URL]
      create_access_code
    end
  end
end
