module EwayRapid
  class CreateAccessCodeResponse
    attr_accessor :customer
    attr_accessor :payment
    attr_accessor :access_code
    attr_accessor :form_action_url
    attr_accessor :errors
    attr_accessor :complete_checkout_url
    attr_accessor :total_amount
    attr_accessor :invoice_number
    attr_accessor :invoice_description
    attr_accessor :invoice_reference
    attr_accessor :currency_code
    attr_accessor :token_customer_id
    attr_accessor :reference
    attr_accessor :title
    attr_accessor :first_name
    attr_accessor :last_name
    attr_accessor :company_name
    attr_accessor :job_description
    attr_accessor :street1
    attr_accessor :street2
    attr_accessor :city
    attr_accessor :state
    attr_accessor :postal_code
    attr_accessor :country
    attr_accessor :email
    attr_accessor :phone
    attr_accessor :mobile
    attr_accessor :comments
    attr_accessor :fax
    attr_accessor :url
    attr_accessor :card_number
    attr_accessor :card_name
    attr_accessor :card_expiry_month
    attr_accessor :card_expiry_year
    attr_accessor :card_start_month
    attr_accessor :card_start_year
    attr_accessor :card_issue_number
    attr_accessor :amex_ec_data

    def to_json(options={})
      {Constants::CUSTOMER               => customer,
       Constants::PAYMENT                => payment,
       Constants::ACCESS_CODE            => access_code,
       Constants::FORM_ACTION_URL        => form_action_url,
       Constants::ERRORS_CAPITALIZED     => errors,
       Constants::COMPLETE_CHECKOUT_URL  => complete_checkout_url,
       Constants::TOTAL_AMOUNT           => total_amount,
       Constants::INVOICE_NUMBER         => invoice_number,
       Constants::INVOICE_DESCRIPTION    => invoice_description,
       Constants::INVOICE_REFERENCE      => invoice_reference,
       Constants::CURRENCY_CODE          => currency_code,
       Constants::TOKEN_CUSTOMER_ID      => token_customer_id,
       Constants::REFERENCE              => reference,
       Constants::TITLE                  => title,
       Constants::FIRST_NAME             => first_name,
       Constants::LAST_NAME              => last_name,
       Constants::COMPANY_NAME           => company_name,
       Constants::JOB_DESCRIPTION        => job_description,
       Constants::STREET1                => street1,
       Constants::STREET2                => street2,
       Constants::CITY                   => city,
       Constants::STATE                  => state,
       Constants::POSTAL_CODE            => postal_code,
       Constants::COUNTRY                => country,
       Constants::EMAIL                  => email,
       Constants::PHONE                  => phone,
       Constants::MOBILE                 => mobile,
       Constants::COMMENTS               => comments,
       Constants::FAX                    => fax,
       Constants::URL                    => url,
       Constants::CARD_NUMBER            => card_number,
       Constants::CARD_NAME              => card_name,
       Constants::CARD_EXPIRY_MONTH      => card_expiry_month,
       Constants::CARD_EXPIRY_YEAR       => card_expiry_year,
       Constants::CARD_START_MONTH       => card_start_month,
       Constants::CARD_START_YEAR        => card_start_year,
       Constants::CARD_ISSUE_NUMBER      => card_issue_number,
       Constants::AMEX_EC_DATA           => amex_ec_data}.to_json
    end

    def self.from_json(json)
      hash = JSON.parse(json)
      from_hash(hash)
    end

    def self.from_hash(hash)
      create_access_code_response = CreateAccessCodeResponse.new
      create_access_code_response.customer = InternalModels::Customer.from_hash(hash[Constants::CUSTOMER])
      create_access_code_response.payment = InternalModels::Payment.from_hash(hash[Constants::PAYMENT])
      create_access_code_response.access_code = hash[Constants::ACCESS_CODE]
      create_access_code_response.form_action_url = hash[Constants::FORM_ACTION_URL]
      create_access_code_response.errors = hash[Constants::ERRORS_CAPITALIZED]
      create_access_code_response.complete_checkout_url = hash[Constants::COMPLETE_CHECKOUT_URL]
      create_access_code_response.total_amount = hash[Constants::TOTAL_AMOUNT]
      create_access_code_response.invoice_number = hash[Constants::INVOICE_NUMBER]
      create_access_code_response.invoice_description = hash[Constants::INVOICE_DESCRIPTION]
      create_access_code_response.invoice_reference = hash[Constants::INVOICE_REFERENCE]
      create_access_code_response.currency_code = hash[Constants::CURRENCY_CODE]
      create_access_code_response.token_customer_id = hash[Constants::TOKEN_CUSTOMER_ID]
      create_access_code_response.reference = hash[Constants::REFERENCE]
      create_access_code_response.title = hash[Constants::TITLE]
      create_access_code_response.first_name = hash[Constants::FIRST_NAME]
      create_access_code_response.last_name = hash[Constants::LAST_NAME]
      create_access_code_response.company_name = hash[Constants::COMPANY_NAME]
      create_access_code_response.job_description = hash[Constants::JOB_DESCRIPTION]
      create_access_code_response.street1 = hash[Constants::STREET1]
      create_access_code_response.street2 = hash[Constants::STREET2]
      create_access_code_response.city = hash[Constants::CITY]
      create_access_code_response.state = hash[Constants::STATE]
      create_access_code_response.postal_code = hash[Constants::POSTAL_CODE]
      create_access_code_response.country = hash[Constants::COUNTRY]
      create_access_code_response.email = hash[Constants::EMAIL]
      create_access_code_response.phone = hash[Constants::PHONE]
      create_access_code_response.mobile = hash[Constants::MOBILE]
      create_access_code_response.comments = hash[Constants::COMMENTS]
      create_access_code_response.fax = hash[Constants::FAX]
      create_access_code_response.url = hash[Constants::URL]
      create_access_code_response.card_number = hash[Constants::CARD_NUMBER]
      create_access_code_response.card_name = hash[Constants::CARD_NAME]
      create_access_code_response.card_expiry_month = hash[Constants::CARD_EXPIRY_MONTH]
      create_access_code_response.card_expiry_year = hash[Constants::CARD_EXPIRY_YEAR]
      create_access_code_response.card_start_month = hash[Constants::CARD_START_MONTH]
      create_access_code_response.card_start_year = hash[Constants::CARD_START_YEAR]
      create_access_code_response.card_issue_number = hash[Constants::CARD_ISSUE_NUMBER]
      create_access_code_response.amex_ec_data = hash[Constants::AMEX_EC_DATA]
      create_access_code_response
    end
  end
end
