module EwayRapid
  module Message
    module RefundProcess

      # Refund message process
      class RefundMsgProcess
        include RestProcess

        # @param [Models::Refund] refund
        # @return [DirectRefundRequest]
        def self.create_request(refund)
          converter = Convert::Request::RefundToDirectRefundReq.new
          converter.do_convert(refund)
        end

        # @param [DirectRefundRequest] request
        # @return [String]
        def self.send_request(url, api_key, password, version, request)
          url = url + '/' + request.refund.original_transaction_id.to_s + '/' + Constants::REFUND_SUB_PATH_METHOD
          url = URI.encode(url)
          RefundMsgProcess.new.do_post(url, api_key, password, version, request)
        end

        # @param [String] response
        # @return [RefundResponse]
        def self.make_result(response)
          response = DirectRefundResponse.from_json(response)
          converter = Convert::Response::DirectRefundToRefundResponse.new
          converter.do_convert(response)
        end
      end

      # cancel authorisation message process
      class CancelAuthorisationMsgProcess
        include RestProcess

        # @param [Models::Refund] refund
        # @return [CancelAuthorisationRequest]
        def self.create_request(refund)
          set_refund(refund)
          request = CancelAuthorisationRequest.new

          # @type [InternalModels::RefundDetails]
          refund_detail = refund.refund_details
          unless refund_detail
            fail 'Refund detail has been null'
          end
          request.transaction_id = refund_detail.original_transaction_id
          request
        end

        def self.send_request(url, api_key, password, version, request)
          CancelAuthorisationMsgProcess.new.do_post(url, api_key, password, version, request)
        end

        # @param [String] response
        # @return [RefundResponse]
        def self.make_result(response)
          cancel_response = CancelAuthorisationResponse.from_json(response)
          converter = Convert::Response::CancelAuthorisationToRefund.new(get_refund)
          converter.do_convert(cancel_response)
        end

        # @param [Models::Refund] refund
        def self.set_refund(refund)
          @refund = refund
        end

        # @return [Models::Refund]
        def self.get_refund
          @refund
        end
      end
    end
  end
end
