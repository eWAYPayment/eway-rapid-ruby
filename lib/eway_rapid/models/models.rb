module EwayRapid
  module Models

    # Customer's address
    class Address

      # First line of the street address
      attr_accessor :street1

      # Second line of the street address
      attr_accessor :street2

      attr_accessor :city
      attr_accessor :state

      # Two letter ISO 3166-1 alpha-2 code
      attr_accessor :country

      attr_accessor :postal_code
    end

    # Card information
    class CardDetails
      attr_accessor :name
      attr_accessor :number
      attr_accessor :expiry_month
      attr_accessor :expiry_year
      attr_accessor :start_month
      attr_accessor :start_year
      attr_accessor :issue_number
      attr_accessor :cvn

      def self.to_hash(card_details)
        { Constants::NAME => card_details.name,
         Constants::NUMBER => card_details.number,
         Constants::EXPIRY_MONTH => card_details.expiry_month,
         Constants::EXPIRY_YEAR => card_details.expiry_year,
         Constants::START_MONTH => card_details.start_month,
         Constants::START_YEAR => card_details.start_year,
         Constants::ISSUE_NUMBER => card_details.issue_number,
         Constants::CVN => card_details.cvn } if card_details
      end

      def self.from_json(json)
        hash = JSON.parse(json)
        from_hash(hash)
      end

      def self.from_hash(hash)
        unless hash.nil?
          card_details = CardDetails.new
          card_details.name = hash[Constants::NAME]
          card_details.number = hash[Constants::NUMBER]
          card_details.expiry_month = hash[Constants::EXPIRY_MONTH]
          card_details.expiry_year = hash[Constants::EXPIRY_YEAR]
          card_details.start_month = hash[Constants::START_MONTH]
          card_details.start_year = hash[Constants::START_YEAR]
          card_details.issue_number = hash[Constants::ISSUE_NUMBER]
          card_details.cvn = hash[Constants::CVN]
          card_details
        end
      end
    end

    # Customer details
    class Customer
      attr_accessor :token_customer_id
      attr_accessor :reference
      attr_accessor :title
      attr_accessor :first_name
      attr_accessor :last_name
      attr_accessor :company_name
      attr_accessor :job_description
      attr_accessor :address
      attr_accessor :phone
      attr_accessor :mobile
      attr_accessor :email
      attr_accessor :fax
      attr_accessor :url
      attr_accessor :comments
      attr_accessor :card_details
      attr_accessor :redirect_url
      attr_accessor :cancel_url
      attr_accessor :customer_device_ip
    end

    # Item information
    class LineItem

      # The stock keeping unit used to identify this line item
      attr_accessor :sku
      attr_accessor :description
      attr_accessor :quantity

      # The unit cost of this line item in cents
      attr_accessor :unit_cost

      # The tax amount that applies to this line item in cents
      attr_accessor :tax

      # The total amount (including tax) charged for this line item in the cents
      attr_accessor :total

      # Set the line item's values so that the total and tax add up
      # correctly
      #
      # @param [Integer] unit_cost
      # @param [Integer] unit_tax
      # @param [Integer] quantity
      def calculate(unit_cost, unit_tax, quantity)
        if unit_cost && unit_tax && quantity
          tax = unit_tax * quantity
          quantity * unit_cost + tax
        end
      end

      def self.to_hash(line_item)
        { Constants::SKU => line_item.sku,
         Constants::DESCRIPTION => line_item.description,
         Constants::QUANTITY => line_item.quantity,
         Constants::UNIT_COST => line_item.unit_cost,
         Constants::TAX => line_item.tax,
         Constants::TOTAL => line_item.total } if line_item
      end

      def self.to_array(array)
        line_items = []
        if array
          array.each {|line_item_hash|
            obj = to_hash(line_item_hash)
            line_items.push(obj)
          }
        end
        line_items
      end

      def self.from_json(json)
        hash = JSON.parse(json)
        from_hash(hash)
      end

      def self.from_hash(hash)
        line_item = LineItem.new
        line_item.sku = hash[Constants::SKU]
        line_item.description = hash[Constants::DESCRIPTION]
        line_item.quantity = hash[Constants::QUANTITY]
        line_item.unit_cost = hash[Constants::UNIT_COST]
        line_item.tax = hash[Constants::TAX]
        line_item.total = hash[Constants::TOTAL]
        line_item
      end

      def self.from_array(array)
        line_items = Array.new
        array.each {|line_item_hash|
          obj = from_hash(line_item_hash)
          line_items.push(obj)
        }
        line_items
      end
    end

    # Details of the payment
    class PaymentDetails

      # The total amount of the transaction in cents
      attr_accessor :total_amount

      attr_accessor :invoice_number
      attr_accessor :invoice_description
      attr_accessor :invoice_reference

      # The ISO 4217 3 character code of the currency that the transaction is
      # to be processed in (e.g. 'AUD')
      attr_accessor :currency_code
    end

    # Combines together all the bank/gateway specific status information for a
    # transaction
    class ProcessingDetails

      # The bank's authorization code for the transaction
      attr_accessor :authorisation_code

      # The bank's Response code
      attr_accessor :response_code

      # The bank or gateway's Response message
      attr_accessor :response_message
    end

    # Contains the high level properties required to process a refund
    # (or Authorisation Cancel)
    class Refund
      attr_accessor :customer
      attr_accessor :shipping_details
      attr_accessor :refund_details
      attr_accessor :line_items
      attr_accessor :options
      attr_accessor :device_id
      attr_accessor :partner_id
    end

    # Contains the Shipping related information for a transaction
    class ShippingDetails
      attr_accessor :first_name
      attr_accessor :last_name
      attr_accessor :shipping_method
      attr_accessor :shipping_address
      attr_accessor :email
      attr_accessor :phone
      attr_accessor :fax
    end

    # The details of a transaction that will be processed either via the responsive
    # shared page, by transparent redirect, by Direct, or one that is captured from
    # a previous Authorisation transaction
    class Transaction

      # The type of transaction being performed - use Enums::TransactionType
      attr_accessor :transaction_type

      # Set to true to capture funds immediately, false to authorise only
      attr_accessor :capture

      # Customer details for the transaction
      attr_accessor :customer

      # Shipping details fo the transaction
      attr_accessor :shipping_details

      # Payment details for the transaction
      attr_accessor :payment_details

      # Array of line items for the transaction
      attr_accessor :line_items

      # Array of options to pass to eWAY
      attr_accessor :options

      # The identification name/number for the device or application processing the transaction
      attr_accessor :device_id

      # The partner ID generated from an eWAY partner agreement
      attr_accessor :partner_id

      # Deprecated, use secured_card_data
      attr_accessor :third_party_wallet_id
      
      # Card data ID, used for Secure Fields, Visa Checkout, AMEX Express Checkout and Android Pay
      attr_accessor :secured_card_data

      # The Transaction ID of an authorisation to capture
      attr_accessor :auth_transaction_id

      # The URL that the shared page redirects to after a payment is processed
      # (transparent redirect & responsive shared page only)
      attr_accessor :redirect_url

      # The URL that the shared page redirects to if a customer cancels the transaction
      # (responsive shared page only)
      attr_accessor :cancel_url

      # Setting this to +true+ will process a PayPal Checkout payment.
      attr_accessor :checkout_payment

      # The URL that the customer is to be returned to after logging in to their PayPal account.
      # (transparent redirect & responsive shared page with PayPal Checkout only)
      attr_accessor :checkout_url

      # Set the theme of the Responsive Shared Page from 12 available themes
      attr_accessor :custom_view

      # Short text description to be placed under the logo on the Responsive Shared Page
      attr_accessor :header_text

      # Language code determines the language that the shared page will be displayed in.
      # One of: EN (English, default), ES (Spanish)
      attr_accessor :language

      # When set to false, cardholders will be able to edit the information on the Responsive Shared Page
      attr_accessor :customer_read_only

      # Set whether the customer's phone number should be confirmed using Beagle Verify
      attr_accessor :verify_customer_phone

      # Set whether the customer's email should be confirmed using Beagle Verify
      attr_accessor :verify_customer_email

      # The URL of the merchant's logo to display on the Responsive Shared Page
      attr_accessor :logo_url

      # Set to true to create a token customer when the transaction is complete
      attr_accessor :save_customer

      # An eWAY-issued ID that represents the Token customer that was loaded or created for this transaction (if applicable)
      attr_accessor :token_customer_id

      alias_method :customer_read_only?, :customer_read_only
      alias_method :checkout_payment?, :checkout_payment
      alias_method :verify_customer_phone?, :verify_customer_phone
      alias_method :verify_customer_email?, :verify_customer_email

      def initialize
        @capture = true
      end
    end

    # Contains the status information for a transaction
    class TransactionStatus
      attr_accessor :transaction_id
      attr_accessor :total
      attr_accessor :status
      attr_accessor :captured
      attr_accessor :beagle_score
      attr_accessor :fraud_action
      attr_accessor :verification_result
      attr_accessor :processing_details

      alias_method :status?, :status
    end

    # Contains the result of all the Beagle and Payment provider verification
    class VerificationResult
      # Currently unused
      attr_accessor :cvn
      # Currently unused
      attr_accessor :address
      # Currently unused
      attr_accessor :email
      # Currently unused
      attr_accessor :mobile
      # Currently unused
      attr_accessor :phone

      # The result of the Beagle Verify email verification
      attr_accessor :beagle_email

      # The result of the Beagle Verify phone verification
      attr_accessor :beagle_phone
    end

    class SettlementSearch
      attr_accessor :report_mode
      attr_accessor :settlement_date
      attr_accessor :start_date
      attr_accessor :end_date
      attr_accessor :card_type
      attr_accessor :currency
      attr_accessor :page
      attr_accessor :page_size
    end

    class SettlementSummary
      attr_accessor :settlement_id
      attr_accessor :currency
      attr_accessor :currency_code
      attr_accessor :total_credit
      attr_accessor :total_debit
      attr_accessor :total_balance
      attr_accessor :balance_per_card_type
    end

    class BalancePerCardType
      attr_accessor :card_type
      attr_accessor :number_of_transactions
      attr_accessor :credit
      attr_accessor :debit
      attr_accessor :balance
    end

    class SettlementTransaction
      attr_accessor :settlement_id
      attr_accessor :eway_customer_id
      attr_accessor :currency
      attr_accessor :currency_code
      attr_accessor :transaction_id
      attr_accessor :txn_reference
      attr_accessor :card_type
      attr_accessor :amount
      attr_accessor :transaction_type
      attr_accessor :transaction_date
      attr_accessor :settlement_date
    end
  end
end
