module EwayRapid
  module Message
    module Convert
      class DirectPaymentToTransStatus

        # @param [DirectPaymentResponse] response
        # @return [Models::TransactionStatus]
        def do_convert(response)
          status = Models::TransactionStatus.new
          status.beagle_score = !response.beagle_score.nil? ? response.beagle_score : 0.0
          status.captured = to_boolean(response.transaction_captured)
          status.fraud_action = response.fraud_action if response.fraud_action
          status.processing_details = get_processing_details(response)
          status.status = response.transaction_status if response.transaction_status
          status.total = response.payment.total_amount if response.payment
          status.transaction_id = if response.transaction_id
                                    begin
                                      Integer(response.transaction_id)
                                    rescue
                                      raise ArgumentError.new 'Invalid transaction id when converting direct payment to transaction status'
                                    end
                                  else
                                    0
                                  end

          verification_convert = VerificationToVerificationResult.new
          status.verification_result = verification_convert.do_convert(response.verification)
          status
        end

        def to_boolean(string)
          string == 'true'
        end

        # @param [DirectPaymentResponse] response
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
