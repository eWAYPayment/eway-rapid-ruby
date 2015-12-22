module EwayRapid
  module Message
    module Convert
      module Response
        class AccessCodeToCreateTrans

          # @param [CreateAccessCodeResponse] response
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
            transaction_response.access_code = response.access_code
            transaction_response.form_action_url = response.form_action_url
            transaction_response
          end
        end
      end
    end
  end
end