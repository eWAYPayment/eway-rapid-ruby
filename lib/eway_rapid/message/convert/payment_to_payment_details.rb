module EwayRapid
  module Message
    module Convert
      class PaymentToPaymentDetails

        # @param [InternalModels::Payment] payment
        # @return [Models::PaymentDetails]
        def do_convert(payment)
          detail = Models::PaymentDetails.new

          if payment
            detail.currency_code = payment.currency_code
            detail.invoice_description = payment.invoice_description
            detail.invoice_number = payment.invoice_number
            detail.invoice_reference = payment.invoice_reference
            detail.total_amount = payment.total_amount
          else
            detail.total_amount = 0
          end
          detail
        end
      end
    end
  end
end
