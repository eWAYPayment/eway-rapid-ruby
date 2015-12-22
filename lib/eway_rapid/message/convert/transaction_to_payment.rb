module EwayRapid
  module Message
    module Convert
      class TransactionToPayment

        # @param [Models::Transaction] transaction
        # @return [InternalModels::Payment]
        def do_convert(transaction)
          payment = InternalModels::Payment.new

          # @type [Models::PaymentDetails]
          payment_details = transaction.payment_details

          if payment_details
            payment.currency_code = payment_details.currency_code
            payment.invoice_description = payment_details.invoice_description
            payment.invoice_number = payment_details.invoice_number
            payment.invoice_reference = payment_details.invoice_reference
            payment.total_amount = payment_details.total_amount
          else
            payment.total_amount = 0
          end

          payment
        end
      end
    end
  end
end
