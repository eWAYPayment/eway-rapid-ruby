module EwayRapid
  module Message
    module Convert
      module Response
        class AccessCodeToCreateCust

          # @param [CreateAccessCodeResponse] response
          # @return [CreateCustomerResponse]
          def do_convert(response)
            customer_response = CreateCustomerResponse.new
            customer_response.access_code = response.access_code
            customer_response.form_action_url = response.form_action_url

            convert = InternalCustomerToCustomer.new
            customer_response.customer = convert.do_convert(response.customer)

            customer_response.errors = response.errors.split(/\s*,\s*/) if response.errors
            customer_response
          end
        end
      end
    end
  end
end