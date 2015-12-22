module EwayRapid
  module Message
    module Convert
      module Response
        class DirectPaymentToCreateCust

          # @param [DirectPaymentResponse] response
          # @return [CreateCustomerResponse]
          def do_convert(response)
            customer_response = CreateCustomerResponse.new
            cust_convert = InternalCustomerToCustomer.new

            customer_response.customer = cust_convert.do_convert(response.customer)

            customer_response.errors = response.errors.split(/\s*,\s*/) if response.errors

            customer_response
          end
        end
      end
    end
  end
end