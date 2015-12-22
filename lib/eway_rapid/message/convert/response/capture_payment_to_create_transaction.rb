module EwayRapid
  module Message
    module Convert
      module Response
        class CapturePaymentToCreateTransaction

          # @param [CapturePaymentResponse] capture
          # @return [CreateTransactionResponse]
          def do_convert(capture)
            response = CreateTransactionResponse.new
            status = Models::TransactionStatus.new
            begin
              status.transaction_id = parse_int(capture.transaction_id) if capture.transaction_id
            rescue
              raise ArgumentError.new 'Convert transaction id ' + capture.transaction_id + ' to integer error'
            end

            status.status = capture.transaction_status

            detail = Models::ProcessingDetails.new
            detail.response_code = capture.errors
            detail.response_code = capture.response_code
            detail.response_message = capture.response_message

            status.processing_details = detail

            response.transaction_status = status
            response.errors = capture.errors.split(/\s*,\s*/) if capture.errors
            response
          end

          def parse_int(string)
            begin
              Integer(string)
            rescue RuntimeError
              raise ArgumentError.new 'Convert transaction id ' + capture.transaction_id + ' to integer error'
            end
          end
        end
      end
    end
  end
end