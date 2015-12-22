module EwayRapid
  module Exceptions

    # The root exception class for all of business Rapid API exceptions
    # Optional parameters :
    # * :error_code the business error code
    class RapidSdkException < StandardError
      attr_accessor :error_code

      def initialize(error_code, message)
        super(message)
        @error_code = error_code
      end
    end

    # Rapid API key, password or endpoint invalid exception
    class APIKeyInvalidException < RapidSdkException
      def initialize(message)
        super(Constants::API_KEY_INVALID_ERROR_CODE, message)
      end
    end

    # Authentication to Rapid API failed (server returned HTTP 40*)
    class AuthenticationFailureException < RapidSdkException
      def initialize(message)
        super(Constants::AUTHENTICATION_FAILURE_ERROR_CODE, message)
      end
    end

    # Error connecting to Rapid API
    class CommunicationFailureException < RapidSdkException
      def initialize(message)
        super(Constants::COMMUNICATION_FAILURE_ERROR_CODE, message)
      end
    end

    # Invalid parameter exception
    class ParameterInvalidException < RapidSdkException
      def initialize(message)
        super(Constants::INTERNAL_RAPID_API_ERROR_CODE, message)
      end
    end

    # Invalid response from Rapid API
    class SystemErrorException <RapidSdkException
      def initialize(message)
        super(Constants::INTERNAL_RAPID_SERVER_ERROR_CODE, message)
      end
    end
  end
end