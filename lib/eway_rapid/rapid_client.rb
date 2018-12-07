module EwayRapid

  # This class abstracts the Rapid API 3.1 functions so that it can be consumed
  # by Ruby applications
  #
  # @author eWAY
  class RapidClient

    # @param [String] api_key eWAY Rapid API key
    # @param [String] password eWAY Rapid API password
    # @param [String] rapid_endpoint eWAY Rapid endpoint - either Sandbox or Production
    def initialize(api_key, password, rapid_endpoint)
      @logger = RapidLogger.logger
      @logger.info "Initiate client with end point: #{rapid_endpoint}" if @logger

      @api_key = api_key
      @password = password
      @rapid_endpoint = rapid_endpoint
      @version = 31

      validate_api_param
    end

    # Changes the API Key and Password the Client is configured to use
    #
    # @param [String] api_key eWAY Rapid API key
    # @param [String] password eWAY Rapid API password
    def set_credentials(api_key, password)
      @api_key = api_key
      @password = password

      validate_api_param
    end

    # Sets the Rapid API version to use (e.g. 40)
    #
    # @param [Integer] version eWAY Rapid API version
    def set_version(version)
      @version = version
    end

    # Creates a transaction either using an authorisation, the responsive shared
    # page, transparent redirect, or direct as the source of funds
    #
    # @param [Enums::PaymentMethod] payment_method Describes where the card details will be coming from for this transaction (Direct, Responsive Shared, Transparent Redirect etc)
    # @param [Models::Transaction] transaction Request containing the transaction details
    # @return [CreateTransactionResponse] CreateTransactionResponse
    def create_transaction(payment_method, transaction)
      unless get_valid?
        return make_response_with_exception(Exceptions::APIKeyInvalidException.new('API key, password or Rapid endpoint missing or invalid'), CreateTransactionResponse)
      end
      begin
        case payment_method
        when Enums::PaymentMethod::DIRECT
          url = @web_url + Constants::DIRECT_PAYMENT_METHOD_NAME + Constants::JSON_SUFFIX

          request = Message::TransactionProcess::TransDirectPaymentMsgProcess.create_request(transaction)
          response = Message::TransactionProcess::TransDirectPaymentMsgProcess.send_request(url, @api_key, @password, @version, request)
          Message::TransactionProcess::TransDirectPaymentMsgProcess.make_result(response)
        when Enums::PaymentMethod::RESPONSIVE_SHARED
          url = @web_url + Constants::RESPONSIVE_SHARED_METHOD_NAME + Constants::JSON_SUFFIX

          request = Message::TransactionProcess::TransResponsiveSharedMsgProcess.create_request(transaction)
          response = Message::TransactionProcess::TransResponsiveSharedMsgProcess.send_request(url, @api_key, @password, @version, request)
          Message::TransactionProcess::TransResponsiveSharedMsgProcess.make_result(response)
        when Enums::PaymentMethod::TRANSPARENT_REDIRECT
          url = @web_url + Constants::TRANSPARENT_REDIRECT_METHOD_NAME + Constants::JSON_SUFFIX

          request = Message::TransactionProcess::TransTransparentRedirectMsgProcess.create_request(transaction)
          response = Message::TransactionProcess::TransTransparentRedirectMsgProcess.send_request(url, @api_key, @password, @version, request)
          Message::TransactionProcess::TransTransparentRedirectMsgProcess.make_result(response)
        when Enums::PaymentMethod::WALLET
          if transaction.capture
            url = @web_url + Constants::DIRECT_PAYMENT_METHOD_NAME + Constants::JSON_SUFFIX

            request = Message::TransactionProcess::TransDirectPaymentMsgProcess.create_request(transaction)
            response = Message::TransactionProcess::TransDirectPaymentMsgProcess.send_request(url, @api_key, @password, @version, request)
            Message::TransactionProcess::TransDirectPaymentMsgProcess.make_result(response)
          else
            url = @web_url + Constants::CAPTURE_PAYMENT_METHOD

            request = Message::TransactionProcess::CapturePaymentMsgProcess.create_request(transaction)
            response = Message::TransactionProcess::CapturePaymentMsgProcess.send_request(url, @api_key, @password, @version, request)
            Message::TransactionProcess::CapturePaymentMsgProcess.make_result(response)
          end
        when Enums::PaymentMethod::AUTHORISATION
          url = @web_url + Constants::CAPTURE_PAYMENT_METHOD

          request = Message::TransactionProcess::CapturePaymentMsgProcess.create_request(transaction)
          response = Message::TransactionProcess::CapturePaymentMsgProcess.send_request(url, @api_key, @password, @version, request)
          Message::TransactionProcess::CapturePaymentMsgProcess.make_result(response)
        else
          make_response_with_exception(Exceptions::ParameterInvalidException.new('Unsupported payment type'), CreateTransactionResponse)
        end
      rescue => e
        @logger.error(e.to_s) if @logger
        make_response_with_exception(e, CreateTransactionResponse)
      end
    end

    # Gets transaction details given an eWAY Transaction ID
    #
    # @param [Integer] transaction_id eWAY Transaction ID
    # @return [QueryTransactionResponse]
    def query_transaction_by_id(transaction_id)
      query_transaction_by_access_code(transaction_id.to_s)
    end

    # Gets transaction details given an access code
    #
    # @param [String] access_code Access code for the transaction to query
    # @return [QueryTransactionResponse]
    def query_transaction_by_access_code(access_code)
      query_transaction_with_path(access_code, Constants::TRANSACTION_METHOD)
    end

    # Query a transaction by one of four properties transaction id, access
    # code, invoice number, invoice reference
    #
    # @param [Enums::TransactionFilter] filter Filter definition for searching
    # @return [QueryTransactionResponse]
    def query_transaction_by_filter(filter)
      index_of_value = filter.calculate_index_of_value
      if index_of_value.nil?
        return make_response_with_exception(Exceptions::APIKeyInvalidException.new('Invalid transaction filter'), QueryTransactionResponse)
      end

      case index_of_value
      when Enums::TransactionFilter::TRANSACTION_ID_INDEX
        query_transaction_by_id(filter.transaction_id.to_s)
      when Enums::TransactionFilter::ACCESS_CODE_INDEX
        query_transaction_by_access_code(filter.access_code)
      when Enums::TransactionFilter::INVOICE_NUMBER_INDEX
        query_transaction_with_path(filter.invoice_number, Constants::TRANSACTION_METHOD + '/' + Constants::TRANSACTION_QUERY_WITH_INVOICE_NUM_METHOD)
      when Enums::TransactionFilter::INVOICE_REFERENCE_INDEX
        query_transaction_with_path(filter.invoice_reference, Constants::TRANSACTION_METHOD + '/' + Constants::TRANSACTION_QUERY_WITH_INVOICE_REF_METHOD)
      else
        make_response_with_exception(Exceptions::APIKeyInvalidException.new('Invalid transaction filter'), QueryTransactionResponse)
      end
    end

    # Refunds all or part of a transaction
    #
    # @param [Models::Refund] refund contains information to refund
    # @return [RefundResponse]
    def refund(refund)
      unless @is_valid
        return make_response_with_exception(Exceptions::APIKeyInvalidException.new('API key, password or Rapid endpoint missing or invalid'), RefundResponse)
      end

      begin
        url = @web_url + Constants::TRANSACTION_METHOD

        request = Message::RefundProcess::RefundMsgProcess.create_request(refund)
        response = Message::RefundProcess::RefundMsgProcess.send_request(url, @api_key, @password, @version, request)
        Message::RefundProcess::RefundMsgProcess.make_result(response)
      rescue => e
        @logger.error(e.to_s) if @logger
        make_response_with_exception(e, RefundResponse)
      end
    end

    # Cancel a non-captured transaction (an authorisation)
    #
    # @param [Models::Refund] refund contains transaction to cancel
    # @return [RefundResponse]
    def cancel(refund)
      unless @is_valid
        return make_response_with_exception(Exceptions::APIKeyInvalidException.new('API key, password or Rapid endpoint missing or invalid'), RefundResponse)
      end
      begin
        url = @web_url + Constants::CANCEL_AUTHORISATION_METHOD

        request = Message::RefundProcess::CancelAuthorisationMsgProcess.create_request(refund)
        response = Message::RefundProcess::CancelAuthorisationMsgProcess.send_request(url, @api_key, @password, @version, request)
        Message::RefundProcess::CancelAuthorisationMsgProcess.make_result(response)
      rescue => e
        @logger.error(e.to_s) if @logger
        make_response_with_exception(e, RefundResponse)
      end
    end

    # Creates a token customer to store card details in the secure eWAY Vault
    # for charging later
    #
    # @param [Enums::PaymentMethod] payment_method Describes where the card details will be coming from for this transaction (Direct, Responsive Shared, Transparent Redirect etc).
    # @param [Models::Customer] customer The customer's details
    # @return [CreateCustomerResponse]
    def create_customer(payment_method, customer)
      unless get_valid?
        return make_response_with_exception(Exceptions::APIKeyInvalidException.new('API key, password or Rapid endpoint missing or invalid'), CreateCustomerResponse)
      end
      begin
        case payment_method
        when Enums::PaymentMethod::DIRECT
          url = @web_url + Constants::DIRECT_PAYMENT_METHOD_NAME + Constants::JSON_SUFFIX

          request = Message::CustomerProcess::CustDirectPaymentMsgProcess.create_request(customer)
          response = Message::CustomerProcess::CustDirectPaymentMsgProcess.send_request(url, @api_key, @password, @version, request)
          Message::CustomerProcess::CustDirectPaymentMsgProcess.make_result(response)
        when Enums::PaymentMethod::RESPONSIVE_SHARED
          url = @web_url + Constants::RESPONSIVE_SHARED_METHOD_NAME + Constants::JSON_SUFFIX

          request = Message::CustomerProcess::CustResponsiveSharedMsgProcess.create_request(customer)
          response = Message::CustomerProcess::CustResponsiveSharedMsgProcess.send_request(url, @api_key, @password, @version, request)
          Message::CustomerProcess::CustResponsiveSharedMsgProcess.make_result(response)
        when Enums::PaymentMethod::TRANSPARENT_REDIRECT
          url = @web_url + Constants::TRANSPARENT_REDIRECT_METHOD_NAME + Constants::JSON_SUFFIX

          request = Message::CustomerProcess::CustTransparentRedirectMsgProcess.create_request(customer)
          response = Message::CustomerProcess::CustTransparentRedirectMsgProcess.send_request(url, @api_key, @password, @version, request)
          Message::CustomerProcess::CustTransparentRedirectMsgProcess.make_result(response)
        else
          make_response_with_exception(Exceptions::ParameterInvalidException.new('Unsupported payment type'), CreateCustomerResponse)
        end
      rescue => e
        @logger.error(e.to_s) if @logger
        make_response_with_exception(e, CreateCustomerResponse)
      end
    end

    # Updates an existing token customer for the merchant in their eWAY account.
    #
    # @param [Enums::PaymentMethod] payment_method Describes where the card details will be coming from for this transaction (Direct, Responsive Shared, Transparent Redirect etc).
    # @param [Models::Customer] customer The customer's details
    # @return [CreateCustomerResponse]
    def update_customer(payment_method, customer)
      unless get_valid?
        return make_response_with_exception(Exceptions::APIKeyInvalidException.new('API key, password or Rapid endpoint missing or invalid'), CreateCustomerResponse)
      end
      begin
        case payment_method
        when Enums::PaymentMethod::DIRECT
          url = @web_url + Constants::DIRECT_PAYMENT_METHOD_NAME + Constants::JSON_SUFFIX
          request = Message::CustomerProcess::CustDirectUpdateMsgProcess.create_request(customer)
          response = Message::CustomerProcess::CustDirectUpdateMsgProcess.send_request(url, @api_key, @password, @version, request)
          Message::CustomerProcess::CustDirectUpdateMsgProcess.make_result(response)
        when Enums::PaymentMethod::RESPONSIVE_SHARED
          url = @web_url + Constants::RESPONSIVE_SHARED_METHOD_NAME + Constants::JSON_SUFFIX

          request = Message::CustomerProcess::CustResponsiveUpdateMsgProcess.create_request(customer)
          response = Message::CustomerProcess::CustResponsiveUpdateMsgProcess.send_request(url, @api_key, @password, @version, request)
          Message::CustomerProcess::CustResponsiveUpdateMsgProcess.make_result(response)
        when Enums::PaymentMethod::TRANSPARENT_REDIRECT
          url = @web_url + Constants::TRANSPARENT_REDIRECT_METHOD_NAME + Constants::JSON_SUFFIX

          request = Message::CustomerProcess::CustTransparentUpdateMsgProcess.create_request(customer)
          response = Message::CustomerProcess::CustTransparentUpdateMsgProcess.send_request(url, @api_key, @password, @version, request)
          Message::CustomerProcess::CustTransparentUpdateMsgProcess.make_result(response)
        else
          return make_response_with_exception(Exceptions::ParameterInvalidException.new('Unsupported payment type'), CreateCustomerResponse)
        end
      rescue => e
        @logger.error(e.to_s) if @logger
        make_response_with_exception(e, CreateCustomerResponse)
      end
    end

    # Returns the details of a Token Customer. This includes the masked card information
    # for displaying in a UI
    #
    # @param [Integer] token_customer_id eWAY Token Customer ID to look up.
    # @return [QueryCustomerResponse]
    def query_customer(token_customer_id)
      @logger.debug('Query customer with id:' + token_customer_id.to_s) if @logger
      unless @is_valid
        return make_response_with_exception(Exceptions::APIKeyInvalidException.new('API key, password or Rapid endpoint missing or invalid'), QueryCustomerResponse)
      end
      begin
        url = @web_url + Constants::DIRECT_CUSTOMER_SEARCH_METHOD + Constants::JSON_SUFFIX
        url = URI.encode(url)

        request = Message::CustomerProcess::QueryCustomerMsgProcess.create_request(token_customer_id.to_s)
        response = Message::CustomerProcess::QueryCustomerMsgProcess.send_request(url, @api_key, @password, @version, request)
        Message::CustomerProcess::QueryCustomerMsgProcess.make_result(response)
      rescue => e
        @logger.error(e.to_s) if @logger
        make_response_with_exception(e, QueryCustomerResponse)
      end
    end

    # Performs a search of settlements
    #
    # @param [SettlementSearch]
    # @return [SettlementSearchResponse]
    def settlement_search(search_request)
      unless @is_valid
        return make_response_with_exception(Exceptions::APIKeyInvalidException.new('API key, password or Rapid endpoint missing or invalid'), QueryCustomerResponse)
      end
      begin

        request = Message::TransactionProcess::SettlementSearchMsgProcess.create_request(search_request)
        url = @web_url + Constants::SETTLEMENT_SEARCH_METHOD +  request

        response = Message::TransactionProcess::SettlementSearchMsgProcess.send_request(url, @api_key, @password, @version)
        Message::TransactionProcess::SettlementSearchMsgProcess.make_result(response)

      rescue => e
        @logger.error(e.to_s) if @logger
        make_response_with_exception(e, SettlementSearchResponse)
      end
    end

    # Translate an error code to a user friendly message
    #
    # @param [String] code The code to translate
    # @param [String] language The 2 letter code for the language to translate to (only en at this time)
    # @return [String] Error message
    def self.user_display_message(code, language = 'en')
      find_error_code(code, language.downcase)
    end

    # Gets the valid status of this Rapid client
    #
    # @return Rapid Client status
    def get_valid?
      @is_valid
    end

    # Returns all errors related to the query request of this client
    #
    # @return List of error codes
    def get_errors
      @list_error || []
    end

    private

    # Perform a transaction query with the given path
    #
    # @param [String] request the transaction identifier to query
    # @param [String] request_path the path to use for the query
    # @return [QueryTransactionResponse]
    def query_transaction_with_path(request, request_path)
      unless @is_valid
        return make_response_with_exception(Exceptions::APIKeyInvalidException.new('API key, password or Rapid endpoint missing or invalid'), QueryTransactionResponse)
      end
      begin
        if request.nil? || request == ''
          url = @web_url + request_path + '/' + '0'
        else
          url = @web_url + request_path + '/' + request
        end
        url = URI.encode(url)

        response = Message::TransactionProcess::TransQueryMsgProcess.process_post_msg(url, @api_key, @password, @version)
        Message::TransactionProcess::TransQueryMsgProcess.make_result(response)
      rescue => e
        @logger.error(e.to_s) if @logger
        make_response_with_exception(e, QueryTransactionResponse)
      end
    end

    # Finds an error code from the properties file
    #
    # @param [String] code
    # @return [String] the error code
    def self.find_error_code(code, language)
      error_file = 'err_code_resource_' + language + '.yml'
      begin
        property_array = YAML.load_file(File.join(File.dirname(__FILE__), 'resources', error_file))
        property_array.each do |h|
          if code == h.keys.first
            return h[h.keys.first]
          end
        end
        return code
      rescue
        @logger.error "Load resource from file: #{error_file} error"  if @logger
        return ''
      end
    end

    # Validates the Rapid API key, password and endpoint
    def validate_api_param
      set_valid(true)
      if @api_key.nil? || @api_key.empty? || @password.nil? || @password.empty?
        add_error_code(Constants::API_KEY_INVALID_ERROR_CODE)
        set_valid(false)
      end
      if @rapid_endpoint.nil? || @rapid_endpoint.empty?
        add_error_code(Constants::LIBRARY_NOT_HAVE_ENDPOINT_ERROR_CODE)
        set_valid(false)
      end
      if @is_valid
        begin
          parser_endpoint_to_web_url
          unless @list_error.nil?
            @list_error.clear
          end
          set_valid(true)
          @logger.info "Initiate client using [#{@web_url}] successful!" if @logger
        rescue => e
          @logger.error "Error setting Rapid endpoint #{e.backtrace.inspect}" if @logger
          set_valid(false)
          add_error_code(Constants::LIBRARY_NOT_HAVE_ENDPOINT_ERROR_CODE)
        end
      else
        @logger.warn 'Invalid parameter passed to Rapid client' if @logger
      end
    end

    # Converts an endpoint string to a URL
    def parser_endpoint_to_web_url
      # @type [String]
      prop_name = nil
      if Constants::RAPID_ENDPOINT_PRODUCTION.casecmp(@rapid_endpoint).zero?
        prop_name = Constants::GLOBAL_RAPID_PRODUCTION_REST_URL_PARAM
      elsif Constants::RAPID_ENDPOINT_SANDBOX.casecmp(@rapid_endpoint).zero?
        prop_name = Constants::GLOBAL_RAPID_SANDBOX_REST_URL_PARAM
      end
      if prop_name.nil?
        set_web_url(@rapid_endpoint)
      else
        property_array = YAML.load_file(File.join(File.dirname(__FILE__), 'resources', 'rapid-api.yml'))
        property_array.each do |h|
          if prop_name.casecmp(h.keys.first).zero?
            set_web_url(h[h.keys.first])
          end
        end
        if @web_url.nil?
          fail Exception, "The endpoint #{prop_name} is invalid."
        end
      end
      # verify_endpoint_url(@web_url) # this is unreliable
    end

    # Checks the Rapid endpoint url
    #
    # @param [String] web_url
    def verify_endpoint_url(web_url)
      begin
        resource = RestClient::Resource.new web_url
        resource.get
      rescue RestClient::Exception => e
        if e.http_code == 404
          set_valid(false)
        end
      end
    end

    # @param [String] error_code
    def add_error_code(error_code)
      if error_code
        if @list_error.nil?
          @list_error = []
          @list_error.push(error_code)
        else
          unless @list_error.include? error_code
            @list_error.push(error_code)
          end
        end
      end
    end

    # @param [Boolean] is_valid
    def set_valid(is_valid)
      @is_valid = is_valid
    end

    # @param [String] web_url
    def set_web_url(web_url)
      @web_url = web_url
    end

    # @param [RapidSdkException] rapid_exception Exception to output
    # @param [ResponseOutput] klass Output class to use for response
    # @return [ResponseOutput]
    def make_response_with_exception(rapid_exception, klass)
      response_output = klass.new
      response_output.errors.push(rapid_exception.error_code)
      response_output
    end
  end
end
