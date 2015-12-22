module EwayRapid
  module Message
    module Convert
      module Response
        class AccessCodeSharedToCreateTrans

          # @param [CreateAccessCodeSharedResponse] response
          # @return [CreateTransactionResponse]
          def do_convert(response)
            transaction_response = CreateTransactionResponse.new
            transaction = Models::Transaction.new
            cust_convert = InternalCustomerToCustomer.new
            transaction.customer = cust_convert.do_convert(response.customer)

            payment_convert = PaymentToPaymentDetails.new
            transaction.payment_details = payment_convert.do_convert(response.payment)

            transaction_response.transaction = transaction
            transaction_response.errors = response.errors.split(/\s*,\s*/) if response.errors
            transaction_response.shared_payment_url = response.shared_payment_url
            transaction_response.access_code = response.access_code
            transaction_response
          end
        end
      end
    end
  end
end