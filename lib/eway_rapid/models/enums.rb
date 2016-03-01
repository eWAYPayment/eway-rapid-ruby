module EwayRapid
  module Enums

    class BeagleVerifyStatus
      NOT_VERIFIED = 'NotVerified'
      ATTEMPTED = 'Attempted'
      VERIFIED = 'Verified'
      FAILED = 'Failed'

      # @param [Integer] index
      # @return [String]
      def self.calculate_beagle_status(index)
        case index
        when 0 then NOT_VERIFIED
        when 1 then ATTEMPTED
        when 2 then VERIFIED
        when 3 then FAILED
        else
          nil
        end
      end
    end

    class FraudAction
      NOT_CHALLENGED = 'NotChallenged'
      ALLOW = 'Allow'
      REVIEW = 'Review'
      PRE_AUTH = 'PreAuth'
      PROCESSED = 'Processed'
      APPROVED = 'Approved'
      BLOCK = 'Block'
    end

    class PaymentMethod
      DIRECT = 'Direct'
      RESPONSIVE_SHARED = 'ResponsiveShared'
      TRANSPARENT_REDIRECT = 'TransparentRedirect'
      WALLET = 'Wallet'
      AUTHORISATION = 'Authorisation'
    end

    class RequestMethod
      PROCESS_PAYMENT = 'ProcessPayment'
      CREATE_TOKEN_CUSTOMER = 'CreateTokenCustomer'
      UPDATE_TOKEN_CUSTOMER = 'UpdateTokenCustomer'
      TOKEN_PAYMENT = 'TokenPayment'
      AUTHORISE = 'Authorise'
    end

    class ShippingMethod
      UNKNOWN = 'Unknown'
      LOW_COST = 'LowCost'
      DESIGNATED_BY_CUSTOMER = 'DesignatedByCustomer'
      INTERNATIONAL = 'International'
      MILITARY = 'Military'
      NEXT_DAY = 'NextDay'
      STORE_PICKUP = 'StorePickup'
      TWO_DAY_SERVICE = 'TwoDayService'
      THREE_DAY_SERVICE = 'ThreeDayService'
      OTHER = 'Other'
    end

    class TransactionType
      PURCHASE = 'Purchase'
      RECURRING = 'Recurring'
      MOTO = 'MOTO'
    end

    class TransactionFilter
      TRANSACTION_ID_INDEX = 1
      ACCESS_CODE_INDEX = 2
      INVOICE_NUMBER_INDEX = 3
      INVOICE_REFERENCE_INDEX = 4

      attr_accessor :transaction_id,
                    :access_code,
                    :invoice_number,
                    :invoice_reference

      # @return [Integer]
      def calculate_index_of_value
        index = 0
        count = 0
        unless transaction_id.nil?
          index = TRANSACTION_ID_INDEX
          count += 1
        end
        unless access_code.nil?
          index = ACCESS_CODE_INDEX
          count += 1
        end
        unless invoice_number.nil?
          index = INVOICE_NUMBER_INDEX
          count += 1
        end
        unless invoice_reference.nil?
          index = INVOICE_REFERENCE_INDEX
          count += 1
        end
        if count == 1
          index
        else
          nil
        end
      end
    end

    class VerifyStatus
      UNCHECKED = 'unchecked'
      VALID = 'valid'
      INVALID = 'invalid'

      # @param [Integer] index
      # @return [String]
      def self.calculate_status(index)
        case index
        when 0 then UNCHECKED
        when 1 then VALID
        when 2 then INVALID
        else
          nil
        end
      end
    end

    class CardType
      ALL = 'ALL'
      VISA = 'VI'
      MASTERCARD = 'MC'
      AMEX = 'AX'
      DINERS = 'DC'
      JCB = 'JC'
      MAESTRO_UK = 'MD'
      MAESTRO_INTERNATIONAL = 'MI'
      SOLO = 'SO'
      LASER = 'LA'
      DISCOVER = 'DS'
    end
  end
end
