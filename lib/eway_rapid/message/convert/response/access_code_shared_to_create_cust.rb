module EwayRapid
  module Message
    module Convert
      module Response
        class AccessCodeSharedToCreateCust

          # @param [CreateAccessCodeSharedResponse] response
          # @return [CreateCustomerResponse]
          def do_convert(response)
            customer_response = CreateCustomerResponse.new
            customer_response.access_code = response.access_code
            customer_response.errors = response.errors.split(/\s*,\s*/) if response.errors

            cust_convert = InternalCustomerToCustomer.new
            customer_response.customer = cust_convert.do_convert(response.customer)
            customer_response.shared_payment_url = response.shared_payment_url
            customer_response
          end
        end
      end
    end
  end
end