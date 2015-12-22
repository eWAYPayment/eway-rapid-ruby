module EwayRapid
  module Message
    module Convert
      module Response
        class CancelAuthorisationToRefund
          attr_reader :refund

          # @param [Models::Refund] refund
          def initialize(refund)
            @refund = refund
          end

          # @param [CancelAuthorisationResponse] cancel
          # @return [RefundResponse]
          def do_convert(cancel)
            response = RefundResponse.new
            response.refund = @refund

            status = Models::TransactionStatus.new
            status.status = cancel.transaction_status

            detail = Models::ProcessingDetails.new
            detail.response_code = cancel.errors
            detail.response_code = cancel.response_code

            status.processing_details = detail
            status.transaction_id = Integer(cancel.transaction_id)

            response.transaction_status = status
            response.errors = cancel.errors.split(/\s*,\s*/) if cancel.errors
            response
          end
        end
      end
    end
  end
end