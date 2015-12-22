module EwayRapid
  module Message
    module Convert
      module Response
        class DirectPaymentToCreateTrans

          # @param [DirectPaymentResponse] response
          # @return [CreateTransactionResponse]
          def do_convert(response)
            transaction_response = CreateTransactionResponse.new
            transaction = Models::Transaction.new

            transaction.transaction_type = response.transaction_type

            payment_converter = PaymentToPaymentDetails.new
            transaction.payment_details = payment_converter.do_convert(response.payment)

            cust_convert = InternalCustomerToCustomer.new
            transaction.customer = cust_convert.do_convert(response.customer)

            transaction_response.transaction = transaction
            transaction_response.errors = response.errors.split(/\s*,\s*/) if response.errors

            status_convert = DirectPaymentToTransStatus.new
            transaction_response.transaction_status = status_convert.do_convert(response)
            transaction_response
          end
        end
      end
    end
  end
end