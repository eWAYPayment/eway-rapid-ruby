module EwayRapid
  module Message
    module Convert
      module Response
        class DirectCustomerToQueryCustomer

          # @param [DirectCustomerSearchResponse] response
          # @return [QueryCustomerResponse]
          def do_convert(response)
            result = QueryCustomerResponse.new
            if response
              result.errors = response.errors.split(/\s*,\s*/) if response.errors

              # @type [Array]
              list_customer = response.customers
              if list_customer && list_customer.length > 0
                list_customer.each do |cust|
                  result.reference = cust.reference
                  result.title = cust.title
                  result.first_name = cust.first_name
                  result.last_name = cust.last_name
                  result.company_name = cust.company_name
                  result.job_description = cust.job_description

                  # @type [String]
                  street = cust.street1
                  if street && street.strip
                    arr = street.split(',', 2)
                    result.street1 = street.split(',', 2).first
                    result.street2 = street.split(',', 2).last if arr.length > 1
                  end

                  result.token_customer_id = cust.token_customer_id
                  result.city = cust.city
                  result.state = cust.state
                  result.postal_code = cust.postal_code
                  result.phone = cust.phone
                  result.mobile = cust.mobile
                  result.email = cust.email
                  result.url = cust.url
                  result.card_detail = cust.card_details
                  result.country = cust.country
                  result.comments = cust.comments
                  result.fax = cust.fax
                  result
                end
              end
            end
            result
          end
        end
      end
    end
  end
end