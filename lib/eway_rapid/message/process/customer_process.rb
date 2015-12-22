module EwayRapid
  module Message
    module CustomerProcess

      # Create customer with direct payment method message process
      class CustDirectPaymentMsgProcess
        include RestProcess

        # @param [Models::Customer] input
        # @return [DirectPaymentRequest]
        def self.create_request(input)
          request = DirectPaymentRequest.new
          convert = Convert::CustomerToInternalCustomer.new(false)
          request.customer = convert.do_convert(input)
          request.customer_ip = input.customer_device_ip
          request.method = Constants::CREATE_TOKEN_CUSTOMER_METHOD
          request.transaction_type = Enums::TransactionType::PURCHASE
          request
        end

        # @param [String] url
        # @param [String] api_key
        # @param [String] password
        # @param [DirectPaymentRequest] request
        # @return [String]
        def self.send_request(url, api_key, password, request)
          begin
            CustDirectPaymentMsgProcess.new.do_post(url, api_key, password, request)
          rescue SocketError => e
            raise Exceptions::CommunicationFailureException.new(e.message)
          rescue RestClient::Exception => e
            if e.http_code == 401 || e.http_code == 403 || e.http_code == 404
              raise Exceptions::AuthenticationFailureException.new(e.message)
            else
              raise Exceptions::SystemErrorException.new(e.message)
            end
          end
        end

        # @param [String] response
        # @return [CreateCustomerResponse]
        def self.make_result(response)
          direct_payment_response = DirectPaymentResponse.from_json(response)
          convert = Convert::Response::DirectPaymentToCreateCust.new
          convert.do_convert(direct_payment_response)
        end
      end

      # Create customer with responsive shared method message process
      class CustResponsiveSharedMsgProcess
        include RestProcess

        # @param [Models::Customer] input
        # @return [CreateAccessCodeSharedRequest]
        def self.create_request(input)
          request = CreateAccessCodeSharedRequest.new
          convert = Convert::CustomerToInternalCustomer.new(false)
          request.customer = convert.do_convert(input)
          request.method = Constants::CREATE_TOKEN_CUSTOMER_METHOD
          request.transaction_type = Enums::TransactionType::PURCHASE
          request.redirect_url = input.redirect_url
          request.cancel_url = input.cancel_url
          request
        end

        # @param [String] url
        # @param [String] api_key
        # @param [String] password
        # @param [CreateAccessCodeSharedRequest] request
        # @return [String]
        def self.send_request(url, api_key, password, request)
          CustResponsiveSharedMsgProcess.new.do_post(url, api_key, password, request)
        end

        # @param [String] response
        # @return [CreateCustomerResponse]
        def self.make_result(response)
          code_shared_response = CreateAccessCodeSharedResponse.from_json(response)
          convert = Convert::Response::AccessCodeSharedToCreateCust.new
          convert.do_convert(code_shared_response)
        end
      end

      # Create customer with transparent redirect message process
      class CustTransparentRedirectMsgProcess
        include RestProcess

        # @param [Models::Customer] input
        # @return [CreateAccessCodeRequest]
        def self.create_request(input)
          request = CreateAccessCodeRequest.new
          convert = Convert::CustomerToInternalCustomer.new(false)
          request.customer = convert.do_convert(input)
          request.method = Constants::CREATE_TOKEN_CUSTOMER_METHOD
          request.transaction_type = Enums::TransactionType::PURCHASE
          request.redirect_url = input.redirect_url
          request
        end

        # @param [String] url
        # @param [String] api_key
        # @param [String] password
        # @param [CreateAccessCodeRequest] request
        # @return [String]
        def self.send_request(url, api_key, password, request)
          CustTransparentRedirectMsgProcess.new.do_post(url, api_key, password, request)
        end

        # @param [String] response
        # @return [CreateCustomerResponse]
        def self.make_result(response)
          access_code_response = CreateAccessCodeResponse.from_json(response)
          convert = Convert::Response::AccessCodeToCreateCust.new
          convert.do_convert(access_code_response)
        end
      end

      # Query customer message process
      class QueryCustomerMsgProcess
        include RestProcess

        # @param [String] token_customer_id
        # @return [DirectCustomerSearchRequest]
        def self.create_request(token_customer_id)
          request = DirectCustomerSearchRequest.new
          request.token_customer_id = token_customer_id
          request
        end

        # @param [DirectCustomerSearchRequest] request
        # @return [String]
        def self.send_request(url, api_key, password, request)
          QueryCustomerMsgProcess.new.do_post(url, api_key, password, request)
        end

        # @param [String] response
        # @return [DirectCustomerSearchResponse]
        def self.make_result(response)
          direct_customer_response = DirectCustomerSearchResponse.from_json(response)
          converter = Convert::Response::DirectCustomerToQueryCustomer.new
          converter.do_convert(direct_customer_response)
        end
      end

      # Create customer with direct payment method message process
      class CustDirectUpdateMsgProcess
        include RestProcess

        # @param [Models::Customer] input
        # @return [DirectPaymentRequest]
        def self.create_request(input)
          request = DirectPaymentRequest.new
          converter = Convert::CustomerToInternalCustomer.new
          payment = InternalModels::Payment.new
          payment.total_amount = 0
          request.payment = payment
          request.customer = converter.do_convert(input)
          request.customer_ip = input.customer_device_ip
          request.method = Constants::UPDATE_TOKEN_CUSTOMER_METHOD
          request.transaction_type = Enums::TransactionType::PURCHASE
          request
        end

        # @param [String] url
        # @param [String] api_key
        # @param [String] password
        # @param [DirectPaymentRequest] request
        def self.send_request(url, api_key, password, request)
          CustDirectUpdateMsgProcess.new.do_post(url, api_key, password, request)
        end

        # @param [String] response
        # @return [CreateCustomerResponse]
        def self.make_result(response)
          direct_response = DirectPaymentResponse.from_json(response)
          converter = Convert::Response::DirectPaymentToCreateCust.new
          converter.do_convert(direct_response)
        end
      end

      # Create customer with responsive shared method message process
      class CustResponsiveUpdateMsgProcess
        include RestProcess

        # @param [Models::Customer] input
        # @return [CreateAccessCodeSharedRequest]
        def self.create_request(input)
          request = CreateAccessCodeSharedRequest.new
          converter = Convert::CustomerToInternalCustomer.new
          payment = InternalModels::Payment.new
          payment.total_amount = 0
          request.payment = payment
          request.customer = converter.do_convert(input)
          request.method = Constants::UPDATE_TOKEN_CUSTOMER_METHOD
          request.transaction_type = Enums::TransactionType::PURCHASE
          request.redirect_url = input.redirect_url
          request.cancel_url = input.cancel_url
          request
        end

        # @param [String] url
        # @param [String] api_key
        # @param [String] password
        # @param [CreateAccessCodeSharedRequest] request
        def self.send_request(url, api_key, password, request)
          CustResponsiveUpdateMsgProcess.new.do_post(url, api_key, password, request)
        end

        # @param [String] response
        # @return [CreateCustomerResponse]
        def self.make_result(response)
          shared_response = CreateAccessCodeSharedResponse.from_json(response)
          converter = Convert::Response::AccessCodeSharedToCreateCust.new
          converter.do_convert(shared_response)
        end
      end

      # Create customer with transparent redirect message process
      class CustTransparentUpdateMsgProcess
        include RestProcess

        # @param [Models::Customer] input
        # @return [CreateAccessCodeRequest]
        def self.create_request(input)
          request = CreateAccessCodeRequest.new
          converter = Convert::CustomerToInternalCustomer.new
          payment = InternalModels::Payment.new
          payment.total_amount = 0
          request.payment = payment
          request.customer = converter.do_convert(input)
          request.method = Constants::UPDATE_TOKEN_CUSTOMER_METHOD
          request.transaction_type = Enums::TransactionType::PURCHASE
          request.redirect_url = input.redirect_url
          request
        end

        # @param [String] url
        # @param [String] api_key
        # @param [String] password
        # @param [CreateAccessCodeRequest] request
        def self.send_request(url, api_key, password, request)
          CustTransparentUpdateMsgProcess.new.do_post(url, api_key, password, request)
        end

        # @param [String] response
        # @return [CreateCustomerResponse]
        def self.make_result(response)
          access_code_response = CreateAccessCodeResponse.from_json(response)
          converter = Convert::Response::AccessCodeToCreateCust.new
          converter.do_convert(access_code_response)
        end
      end
    end
  end
end
