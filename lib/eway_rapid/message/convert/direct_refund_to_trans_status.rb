module EwayRapid
  module Message
    module Convert
      class DirectRefundToTransStatus

        # @param [DirectRefundResponse] response
        # @return [Models::TransactionStatus]
        def do_convert(response)
          status = Models::TransactionStatus.new
          status.processing_details = get_processing_details(response)
          status.status = response.transaction_status if response.transaction_status
          begin
          status.transaction_id = Integer(response.transaction_id) if response.transaction_id
          rescue
            raise ArgumentError.new 'Invalid transaction id when converting direct refund to transaction status'
          end

          status
        end

        # @param [DirectRefundResponse] response
        # @return [Models::ProcessingDetails]
        def get_processing_details(response)
          processing_details = Models::ProcessingDetails.new
          processing_details.authorisation_code = response.authorisation_code
          processing_details.response_code = response.response_code
          processing_details.response_message = response.response_message
          processing_details
        end
      end
    end
  end
end
