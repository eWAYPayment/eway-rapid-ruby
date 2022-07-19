module EwayRapid
  module Message
    module Convert
      class InternalTransactionToStatus

        # @param [InternalModels::Transaction] transaction
        # @return [Models::TransactionStatus]
        def do_convert(transaction)
          transaction_status = Models::TransactionStatus.new
          transaction_status.beagle_score = transaction.beagle_score if transaction.beagle_score
          transaction_status.status = transaction.transaction_status
          transaction_status.total = transaction.total_amount
          transaction_status.processing_details = get_processing_details(transaction)
          transaction_status.verification_result = get_verification_result(transaction)
          transaction_status.transaction_date_time = transaction.transaction_date_time
          transaction_status.transaction_captured = transaction.transaction_captured
          transaction_status.transaction_type = transaction.transaction_type
          transaction_status.source = transaction.source
          transaction_status.max_refund = transaction.max_refund
          transaction_status.original_transaction_id = transaction.original_transaction_id
          transaction_status.fraud_action = transaction.fraud_action
          transaction_status.currency_code = transaction.currency_code

          begin
            transaction_status.transaction_id = Integer(transaction.transaction_id) if transaction.transaction_id
          rescue
            raise ArgumentError.new 'Invalid transaction id when converting transaction to internal transaction status'
          end
          transaction_status
        end

        # @param [InternalModels::Transaction] transaction
        # @return [Models::ProcessingDetails]
        def get_processing_details(transaction)
          processing_details = Models::ProcessingDetails.new
          processing_details.authorisation_code = transaction.authorisation_code
          processing_details.response_code = transaction.response_code
          processing_details.response_message = transaction.response_message
          processing_details
        end

        # @param [InternalModels::Transaction] transaction
        def get_verification_result(transaction)
          converter = VerificationToVerificationResult.new
          verification_result = converter.do_convert(transaction.verification)
          if transaction.beagle_verification
            verification_result.beagle_email = get_beagle_status(transaction.beagle_verification.phone)
            verification_result.beagle_phone = get_beagle_status(transaction.beagle_verification.email)
          end
          verification_result
        end

        def get_beagle_status(status)
          begin
            index = Integer(status)
            Enums::BeagleVerifyStatus.calculate_beagle_status(index)
          rescue StandardError
            return nil
          end
        end
      end
    end
  end
end
