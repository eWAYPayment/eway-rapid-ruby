module EwayRapid
  module Message
    module Convert
      class CustomerToInternalCustomer
        @merge_card_detail_to_this = true

        def initialize(is_merge_card_info = nil)
          @merge_card_detail_to_this = is_merge_card_info unless is_merge_card_info.nil?
        end

        # @param [Models::Customer] customer
        # @return [InternalModels::Customer]
        def do_convert(customer)
          i_customer = InternalModels::Customer.new
          if customer
            i_customer.phone = customer.phone
            i_customer.reference = customer.reference
            i_customer.token_customer_id = customer.token_customer_id
            i_customer.comments = customer.comments
            i_customer.mobile = customer.mobile
            i_customer.title = customer.title
            i_customer.fax = customer.fax
            i_customer.customer_device_ip = customer.customer_device_ip
            i_customer.email = customer.email

            # @type [Models::CardDetails]
            card_details = customer.card_details
            i_customer.card_details = card_details

            if card_details && @merge_card_detail_to_this
              i_customer.card_start_month = card_details.start_month
              i_customer.card_start_year = card_details.start_year
              i_customer.card_issue_number = card_details.issue_number
              i_customer.card_name = card_details.name
              i_customer.card_number = card_details.number
              begin
                i_customer.card_expiry_year = Integer(card_details.expiry_year)
              rescue
                raise ArgumentError.new 'Invalid expiry year in card details'
              end
              begin
                i_customer.card_expiry_month = Integer(card_details.expiry_month)
              rescue
                raise ArgumentError.new 'Invalid expiry month param in card details'
              end
            end

            i_customer.company_name = customer.company_name
            i_customer.url = customer.url
            i_customer.first_name = customer.first_name
            i_customer.last_name = customer.last_name

            # @type [Models::Address]
            cus_address = customer.address
            if cus_address
              i_customer.state = cus_address.state
              i_customer.postal_code = cus_address.postal_code
              i_customer.country = cus_address.country
              i_customer.city = cus_address.city
              i_customer.street1 = cus_address.street1
              i_customer.street2 = cus_address.street2
            end
            i_customer.job_description = customer.job_description
          end
          i_customer
        end
      end
    end
  end
end
