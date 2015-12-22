module EwayRapid
  module Message
    module TransactionProcess

      # Create transaction with direct payment message process
      class TransDirectPaymentMsgProcess
        include RestProcess

        # @param [Models::Transaction] input
        # @return [DirectPaymentRequest]
        def self.create_request(input)
          req_convert = Convert::Request::TransactionToDirectPayment.new
          req_convert.do_convert(input)
        end

        # @param [String] url
        # @param [String] api_key
        # @param [String] password
        # @param [DirectPaymentRequest] request
        # @return [String]
        def self.send_request(url, api_key, password, request)
          TransDirectPaymentMsgProcess.new.do_post(url, api_key, password, request)
        end

        # @param [String] response
        # @return [CreateTransactionResponse]
        def self.make_result(response)
          direct_payment_response = DirectPaymentResponse.from_json(response)
          converter = Convert::Response::DirectPaymentToCreateTrans.new
          converter.do_convert(direct_payment_response)
        end
      end

      # Create transaction with responsive shared message process
      class TransResponsiveSharedMsgProcess
        include RestProcess

        # @param [Models::Transaction] input
        # @return [CreateAccessCodeSharedRequest]AccessCodeSharedToCreateCust
        def self.create_request(input)
          req_convert = Convert::Request::TransactionToCreateAccessCodeSharedRequest.new
          req_convert.do_convert(input)
        end

        # @param [String] url
        # @param [String] api_key
        # @param [String] password
        # @param [CreateAccessCodeSharedRequest] request
        # @return [String]
        def self.send_request(url, api_key, password, request)
          TransResponsiveSharedMsgProcess.new.do_post(url, api_key, password, request)
        end

        # @param [String] response
        # @return [CreateTransactionResponse]
        def self.make_result(response)
          access_code_shared_response = CreateAccessCodeSharedResponse.from_json(response)
          converter = Convert::Response::AccessCodeSharedToCreateTrans.new
          converter.do_convert(access_code_shared_response)
        end
      end

      # Create transaction with transparent redirect method message process
      class TransTransparentRedirectMsgProcess
        include RestProcess

        # @param [Models::Transaction] input
        # @return [CreateAccessCodeRequest]
        def self.create_request(input)
          req_convert = Convert::Request::TransactionToCreateAccessCodeRequest.new
          req_convert.do_convert(input)
        end

        # @param [String] url
        # @param [String] api_key
        # @param [String] password
        # @param [CreateAccessCodeRequest] request
        # @return [String]
        def self.send_request(url, api_key, password, request)
          TransTransparentRedirectMsgProcess.new.do_post(url, api_key, password, request)
        end

        # @param [String] response
        # @return [CreateTransactionResponse]
        def self.make_result(response)
          create_access_code_response = CreateAccessCodeResponse.from_json(response)
          converter = Convert::Response::AccessCodeToCreateTrans.new
          converter.do_convert(create_access_code_response)
        end
      end

      # Capture payment message process
      class CapturePaymentMsgProcess
        include RestProcess

        # @param [Models::Transaction] input
        # @return [CapturePaymentRequest]
        def self.create_request(input)
          req_convert = Convert::Request::TransactionToCapturePayment.new
          req_convert.do_convert(input)
        end

        # @param [String] url
        # @param [String] api_key
        # @param [String] password
        # @param [CapturePaymentRequest] request
        # @return [String]
        def self.send_request(url, api_key, password, request)
          CapturePaymentMsgProcess.new.do_post(url, api_key, password, request)
        end

        # @param [String] response
        # @return [CreateTransactionResponse]
        def self.make_result(response)
          capture_payment_response = CapturePaymentResponse.from_json(response)
          converter = Convert::Response::CapturePaymentToCreateTransaction.new
          converter.do_convert(capture_payment_response)
        end
      end

      # Query transaction message process
      class TransQueryMsgProcess
        include RestProcess

        def self.process_post_msg(url, api_key, password)
          TransQueryMsgProcess.new.do_get(url, api_key, password)
        end

        # @param [String] response
        # @return [QueryTransactionResponse]
        def self.make_result(response)
          transaction_search_resp = TransactionSearchResponse.from_json(response)
          converter = Convert::Response::SearchToQueryTrans.new
          converter.do_convert(transaction_search_resp)
        end
      end
    end
  end
end
