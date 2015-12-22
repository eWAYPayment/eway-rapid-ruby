module EwayRapid
  module Message
    module Convert
      class InternalCustomerToCustomer

        # @param [InternalModels::Customer] i_customer
        # @return [Models::Customer]
        def do_convert(i_customer)
          customer = Models::Customer.new
          if i_customer
            customer.comments = i_customer.comments
            customer.token_customer_id = i_customer.token_customer_id
            customer.mobile = i_customer.mobile
            customer.phone = i_customer.phone
            customer.title = i_customer.title
            customer.company_name = i_customer.company_name
            customer.fax = i_customer.fax
            customer.first_name = i_customer.first_name
            customer.last_name = i_customer.last_name
            customer.job_description = i_customer.job_description
            customer.reference = i_customer.reference
            customer.url = i_customer.url
            customer.customer_device_ip = i_customer.customer_device_ip
            customer.email = i_customer.email

            address = Models::Address.new
            address.city = i_customer.city
            address.street1 = i_customer.street1
            address.street2 = i_customer.street2
            address.postal_code = i_customer.postal_code
            address.country = i_customer.country
            address.state = i_customer.state
            customer.address = address
            customer.card_details = i_customer.card_details
          end
          customer
        end
      end
    end
  end
end
