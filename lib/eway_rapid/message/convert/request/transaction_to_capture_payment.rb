module EwayRapid
  module Message
    module Convert
      module Request
        class TransactionToCapturePayment

          # @param [Models::Transaction] transaction
          # @return [CapturePaymentRequest]
          def do_convert(transaction)
            request = CapturePaymentRequest.new
            request.transaction_id = transaction.auth_transaction_id

            if transaction.payment_details
              payment = InternalModels::Payment.new
              payment.currency_code = transaction.payment_details.currency_code
              payment.invoice_description = transaction.payment_details.invoice_description
              payment.invoice_number = transaction.payment_details.invoice_number
              payment.invoice_reference = transaction.payment_details.invoice_reference
              payment.total_amount = transaction.payment_details.total_amount
              request.payment = payment
            end
            request
          end
        end
      end
    end
  end
end
