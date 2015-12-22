module EwayRapid
  module InternalModels
    class BeagleVerification
      attr_accessor :email
      attr_accessor :phone

      def to_json(options={})
        hash = {}
        hash[Constants::EMAIL] = email
        hash[Constants::PHONE] = phone
        hash.to_json
      end

      def self.from_json(json)
        hash = JSON.parse(json)
        from_hash(hash)
      end

      def self.from_hash(hash)
        beagle_verification = self.new
        beagle_verification.email = hash[Constants::EMAIL]
        beagle_verification.phone = hash[Constants::PHONE]
        beagle_verification
      end
    end

    class Customer
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
      attr_accessor :card_start_month
      attr_accessor :card_start_year
      attr_accessor :card_issue_number
      attr_accessor :card_name
      attr_accessor :card_expiry_month
      attr_accessor :card_expiry_year
      attr_accessor :is_active
      attr_accessor :card_details
      attr_accessor :customer_device_ip

      def self.to_hash(customer)
        hash = {}
        if customer
          hash[Constants::TOKEN_CUSTOMER_ID] = customer.token_customer_id if customer.token_customer_id
          hash[Constants::REFERENCE] = customer.reference if customer.reference
          hash[Constants::TITLE] = customer.title if customer.title
          hash[Constants::FIRST_NAME] = customer.first_name if customer.first_name
          hash[Constants::LAST_NAME] = customer.last_name if customer.last_name
          hash[Constants::COMPANY_NAME] = customer.company_name if customer.company_name
          hash[Constants::JOB_DESCRIPTION] = customer.job_description if customer.job_description
          hash[Constants::STREET1] = customer.street1 if customer.street1
          hash[Constants::STREET2] = customer.street2 if customer.street2
          hash[Constants::CITY] = customer.city if customer.city
          hash[Constants::STATE] = customer.state if customer.state
          hash[Constants::POSTAL_CODE] = customer.postal_code if customer.postal_code
          hash[Constants::COUNTRY] = customer.country if customer.country
          hash[Constants::EMAIL] = customer.email if customer.email
          hash[Constants::PHONE] = customer.phone if customer.phone
          hash[Constants::MOBILE] = customer.mobile if customer.mobile
          hash[Constants::COMMENTS] = customer.comments if customer.comments
          hash[Constants::FAX] = customer.fax if customer.fax
          hash[Constants::URL] = customer.url if customer.url
          hash[Constants::CARD_DETAILS] = Models::CardDetails.to_hash(customer.card_details) if Models::CardDetails.to_hash(customer.card_details)
          hash[Constants::IS_ACTIVE] = customer.is_active if customer.is_active

          hash[Constants::CARD_NUMBER] = customer.card_number if customer.card_number
          hash[Constants::CARD_START_MONTH] = customer.card_start_month if customer.card_start_month
          hash[Constants::CARD_START_YEAR] = customer.card_start_year if customer.card_start_year
          hash[Constants::CARD_ISSUE_NUMBER] = customer.card_issue_number if customer.card_issue_number
          hash[Constants::CARD_NAME] = customer.card_name if customer.card_name
          hash[Constants::CARD_EXPIRY_MONTH] = customer.card_expiry_month if customer.card_expiry_month
          hash[Constants::CARD_EXPIRY_YEAR] = customer.card_expiry_year if customer.card_expiry_year
          hash[Constants::CUSTOMER_DEVICE_IP] = customer.customer_device_ip if customer.customer_device_ip
        end
        hash
      end

      def self.from_json(json)
        hash = JSON.parse(json)
        from_hash(hash)
      end

      def self.from_hash(hash)
        customer = Customer.new
        customer.token_customer_id = hash[Constants::TOKEN_CUSTOMER_ID]
        customer.reference = hash[Constants::REFERENCE]
        customer.title = hash[Constants::TITLE]
        customer.first_name = hash[Constants::FIRST_NAME]
        customer.last_name = hash[Constants::LAST_NAME]
        customer.company_name = hash[Constants::COMPANY_NAME]
        customer.job_description = hash[Constants::JOB_DESCRIPTION]
        customer.street1 = hash[Constants::STREET1]
        customer.street2 = hash[Constants::STREET2]
        customer.city = hash[Constants::CITY]
        customer.state = hash[Constants::STATE]
        customer.postal_code = hash[Constants::POSTAL_CODE]
        customer.country = hash[Constants::COUNTRY]
        customer.email = hash[Constants::EMAIL]
        customer.phone = hash[Constants::PHONE]
        customer.mobile = hash[Constants::MOBILE]
        customer.comments = hash[Constants::COMMENTS]
        customer.fax = hash[Constants::FAX]
        customer.url = hash[Constants::URL]
        customer.card_number = hash[Constants::CARD_NUMBER]
        customer.card_start_month = hash[Constants::CARD_START_MONTH]
        customer.card_start_year = hash[Constants::CARD_START_YEAR]
        customer.card_issue_number = hash[Constants::CARD_ISSUE_NUMBER]
        customer.card_name = hash[Constants::CARD_NAME]
        customer.card_expiry_month = hash[Constants::CARD_EXPIRY_MONTH]
        customer.card_expiry_year = hash[Constants::CARD_EXPIRY_YEAR]
        customer.is_active = hash[Constants::IS_ACTIVE]
        customer.card_details = Models::CardDetails.from_hash(hash[Constants::CARD_DETAILS])
        customer.customer_device_ip = hash[Constants::CUSTOMER_DEVICE_IP]
        customer
      end

      def self.from_array(array)
        options = []
        if array
          array.each {|option_hash|
            obj = Customer.from_hash(option_hash)
            options.push(obj)
          }
        end
        options
      end
    end

    class Option
      attr_accessor :value

      def self.to_hash(option)
        hash = {}
        if option
          hash[Constants::VALUE] = option.value if option.value
        end
        hash
      end

      def self.to_array(array)
        options = []
        if array
          array.each {|option_hash|
            if option_hash
              obj = Option.to_hash(option_hash)
              options.push(obj)
            end
          }
        end
        options
      end

      def self.from_json(json)
        hash = JSON.parse(json)
        from_hash(hash)
      end

      def self.from_hash(hash)
        option = Option.new
        option.value = hash[Constants::VALUE]
        option
      end

      def self.from_array(array)
        options = []
        array.each {|option_hash|
          obj = Option.from_hash(option_hash)
          options.push(obj)
        }
        options
      end
    end

    class Payment
      attr_accessor :total_amount
      attr_accessor :invoice_number
      attr_accessor :invoice_description
      attr_accessor :invoice_reference
      attr_accessor :currency_code

      def self.to_hash(payment)
        hash = {}
        if payment
         hash[Constants::TOTAL_AMOUNT] = payment.total_amount if payment.total_amount
         hash[Constants::INVOICE_NUMBER] = payment.invoice_number if payment.invoice_number
         hash[Constants::INVOICE_DESCRIPTION] = payment.invoice_description if payment.invoice_description
         hash[Constants::INVOICE_REFERENCE] = payment.invoice_reference if payment.invoice_reference
         hash[Constants::CURRENCY_CODE] = payment.currency_code if payment.currency_code
        end
        hash
      end

      def self.from_json(json)
        hash = JSON.parse(json)
        from_hash(hash)
      end

      def self.from_hash(hash)
        payment = Payment.new
        payment.total_amount = hash[Constants::TOTAL_AMOUNT]
        payment.invoice_number = hash[Constants::INVOICE_NUMBER]
        payment.invoice_description = hash[Constants::INVOICE_DESCRIPTION]
        payment.invoice_reference = hash[Constants::INVOICE_REFERENCE]
        payment.currency_code = hash[Constants::CURRENCY_CODE]
        payment
      end
    end

    class RefundDetails
      attr_accessor :original_transaction_id
      attr_accessor :total_amount
      attr_accessor :invoice_number
      attr_accessor :invoice_description
      attr_accessor :invoice_reference
      attr_accessor :currency_code

      def self.to_hash(refund_details)
        hash = {}
        if refund_details
         hash[Constants::ORIGINAL_TRANSACTION_ID] = refund_details.original_transaction_id if refund_details.original_transaction_id
         hash[Constants::TOTAL_AMOUNT] = refund_details.total_amount if refund_details.total_amount
         hash[Constants::INVOICE_NUMBER] = refund_details.invoice_number if refund_details.invoice_number
         hash[Constants::INVOICE_DESCRIPTION] = refund_details.invoice_description if refund_details.invoice_description
         hash[Constants::INVOICE_REFERENCE] = refund_details.invoice_reference if refund_details.invoice_reference
         hash[Constants::CURRENCY_CODE] = refund_details.currency_code if refund_details.currency_code
        end
        hash
      end

      def self.from_json(json)
        hash = JSON.parse(json)
        from_hash(hash)
      end

      def self.from_hash(hash)
        refund_details = RefundDetails.new
        refund_details.original_transaction_id = hash[Constants::ORIGINAL_TRANSACTION_ID]
        refund_details.total_amount = hash[Constants::TOTAL_AMOUNT]
        refund_details.invoice_number = hash[Constants::INVOICE_NUMBER]
        refund_details.invoice_description = hash[Constants::INVOICE_DESCRIPTION]
        refund_details.invoice_reference = hash[Constants::INVOICE_REFERENCE]
        refund_details.currency_code = hash[Constants::CURRENCY_CODE]
        refund_details
      end
    end

    class ShippingAddress
      attr_accessor :first_name
      attr_accessor :last_name
      attr_accessor :street1
      attr_accessor :street2
      attr_accessor :city
      attr_accessor :state
      attr_accessor :country
      attr_accessor :postal_code
      attr_accessor :email
      attr_accessor :phone
      attr_accessor :fax
      attr_accessor :shipping_method

      def self.to_hash(shipping_address)
        hash = {}
        if shipping_address
         hash[Constants::FIRST_NAME] = shipping_address.first_name if shipping_address.first_name
         hash[Constants::LAST_NAME] = shipping_address.last_name if shipping_address.last_name
         hash[Constants::STREET1] = shipping_address.street1 if shipping_address.street1
         hash[Constants::STREET2] = shipping_address.street2 if shipping_address.street2
         hash[Constants::CITY] = shipping_address.city if shipping_address.city
         hash[Constants::STATE] = shipping_address.state if shipping_address.state
         hash[Constants::COUNTRY] = shipping_address.country if shipping_address.country
         hash[Constants::POSTAL_CODE] = shipping_address.postal_code if shipping_address.postal_code
         hash[Constants::EMAIL] = shipping_address.email if shipping_address.email
         hash[Constants::PHONE] = shipping_address.phone if shipping_address.phone
         hash[Constants::FAX] = shipping_address.fax if shipping_address.fax
         hash[Constants::SHIPPING_METHOD] = shipping_address.shipping_method if shipping_address.shipping_method
        end
        hash
      end

      def self.from_json(json)
        hash = JSON.parse(json)
        from_hash(hash)
      end

      def self.from_hash(hash)
        shipping_address = ShippingAddress.new
        shipping_address.first_name = hash[Constants::FIRST_NAME]
        shipping_address.last_name = hash[Constants::LAST_NAME]
        shipping_address.street1 = hash[Constants::STREET1]
        shipping_address.street2 = hash[Constants::STREET2]
        shipping_address.city = hash[Constants::CITY]
        shipping_address.state = hash[Constants::STATE]
        shipping_address.country = hash[Constants::COUNTRY]
        shipping_address.postal_code = hash[Constants::POSTAL_CODE]
        shipping_address.email = hash[Constants::EMAIL]
        shipping_address.phone = hash[Constants::PHONE]
        shipping_address.fax = hash[Constants::FAX]
        shipping_address.shipping_method = hash[Constants::SHIPPING_METHOD]
        shipping_address
      end
    end

    class Transaction
      attr_accessor :customer_note
      attr_accessor :authorisation_code
      attr_accessor :response_code
      attr_accessor :response_message
      attr_accessor :invoice_number
      attr_accessor :invoice_reference
      attr_accessor :total_amount
      attr_accessor :transaction_id
      attr_accessor :transaction_status
      attr_accessor :token_customer_id
      attr_accessor :beagle_score
      attr_accessor :options
      attr_accessor :verification
      attr_accessor :customer
      attr_accessor :shipping_address
      attr_accessor :beagle_verification
      attr_accessor :errors

      def to_json(opts={})
        hash = {}
        hash[Constants::CUSTOMER_NOTE] = customer_note if customer_note
        hash[Constants::AUTHORISATION_CODE] = authorisation_code if authorisation_code
        hash[Constants::RESPONSE_CODE] = response_code if response_code
        hash[Constants::RESPONSE_MESSAGE] = response_message if response_message
        hash[Constants::INVOICE_NUMBER] = invoice_number if invoice_number
        hash[Constants::INVOICE_REFERENCE] = invoice_reference if invoice_reference
        hash[Constants::TOTAL_AMOUNT] = total_amount if total_amount
        hash[Constants::TRANSACTION_ID] = transaction_id if transaction_id
        hash[Constants::TRANSACTION_STATUS] = transaction_status if transaction_status
        hash[Constants::TOKEN_CUSTOMER_ID] = token_customer_id if token_customer_id
        hash[Constants::BEAGLE_SCORE] = beagle_score if beagle_score
        hash[Constants::OPTIONS] = options if options
        hash[Constants::VERIFICATION] = verification if verification
        hash[Constants::CUSTOMER] = customer if customer
        hash[Constants::SHIPPING_ADDRESS] = shipping_address if shipping_address
        hash[Constants::BEAGLE_VERIFICATION] = beagle_verification if beagle_verification
        hash[Constants::ERRORS] = errors if errors
        hash.to_json
      end

      def self.from_json(json)
        hash = JSON.parse(json)
        from_hash(hash)
      end

      def self.from_hash(hash)
        transaction = Transaction.new
        transaction.customer_note = hash[Constants::CUSTOMER_NOTE]
        transaction.authorisation_code = hash[Constants::AUTHORISATION_CODE]
        transaction.response_code = hash[Constants::RESPONSE_CODE]
        transaction.response_message = hash[Constants::RESPONSE_MESSAGE]
        transaction.invoice_number = hash[Constants::INVOICE_NUMBER]
        transaction.invoice_reference = hash[Constants::INVOICE_REFERENCE]
        transaction.total_amount = hash[Constants::TOTAL_AMOUNT]
        transaction.transaction_id = hash[Constants::TRANSACTION_ID]
        transaction.transaction_status = hash[Constants::TRANSACTION_STATUS]
        transaction.token_customer_id = hash[Constants::TOKEN_CUSTOMER_ID]
        transaction.beagle_score = hash[Constants::BEAGLE_SCORE]
        transaction.options = Option.from_array(hash[Constants::OPTIONS])
        transaction.verification = Verification.from_hash(hash[Constants::VERIFICATION])
        transaction.customer = Customer.from_hash(hash[Constants::CUSTOMER])
        transaction.shipping_address = ShippingAddress.from_hash(hash[Constants::SHIPPING_ADDRESS])
        transaction.beagle_verification = BeagleVerification.from_hash(hash[Constants::BEAGLE_VERIFICATION])
        transaction.errors = hash[Constants::ERRORS]
        transaction
      end

      def self.from_array(array)
        transactions = []
        array.each {|transaction_hash|
          obj = from_hash(transaction_hash)
          transactions.push(obj)
        }
        transactions
      end
    end

    class Verification
      attr_accessor :cvn
      attr_accessor :address
      attr_accessor :email
      attr_accessor :mobile
      attr_accessor :phone

      def to_json(options={})
        hash = {}
        hash[Constants::CVN] = cvn if cvn
        hash[Constants::ADDRESS] = address if address
        hash[Constants::EMAIL] = email if email
        hash[Constants::MOBILE] = mobile if mobile
        hash[Constants::PHONE] = phone if phone
        hash.to_json
      end

      def self.from_json(json)
        hash = JSON.parse(json)
        from_hash(hash)
      end

      def self.from_hash(hash)
        verification = Verification.new
        verification.cvn = hash[Constants::CVN]
        verification.address = hash[Constants::ADDRESS]
        verification.email = hash[Constants::EMAIL]
        verification.mobile = hash[Constants::MOBILE]
        verification.phone = hash[Constants::PHONE]
        verification
      end
    end
  end
end
